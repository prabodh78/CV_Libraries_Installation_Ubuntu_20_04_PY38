#include <vector>

#include "caffe/data_layers.hpp"
#include "caffe/layer.hpp"
#include "caffe/util/io.hpp"

namespace caffe {

template <typename Dtype>
void MemoryDataLayer<Dtype>::DataLayerSetUp(const vector<Blob<Dtype>*>& bottom,
     const vector<Blob<Dtype>*>& top) {
  batch_size_ = this->layer_param_.memory_data_param().batch_size();
  channels_ = this->layer_param_.memory_data_param().channels();
  height_ = this->layer_param_.memory_data_param().height();
  width_ = this->layer_param_.memory_data_param().width();
  size_ = channels_ * height_ * width_;
  CHECK_GT(batch_size_ * size_, 0) <<
      "batch_size, channels, height, and width must be specified and"
      " positive in memory_data_param";
  top[0]->Reshape(batch_size_, channels_, height_, width_);
  top[1]->Reshape(batch_size_, 1, 1, 1);
  top[2]->Reshape(batch_size_, 1, 1, 2); // Martin Kersner, 2016/04/06
  added_data_.Reshape(batch_size_, channels_, height_, width_);
  added_label_.Reshape(batch_size_, 1, 1, 1);
  added_data_dim_.Reshape(batch_size_, 1, 1, 2); // Martin Kersner, 2016/04/06
  data_ = NULL;
  labels_ = NULL;
  data_dim_ = NULL; // Martin Kersner, 2016/04/06
  added_data_.cpu_data();
  added_label_.cpu_data();
  added_data_dim_.cpu_data(); // Martin Kersner, 2016/04/06
}

template <typename Dtype>
void MemoryDataLayer<Dtype>::AddDatumVector(const vector<Datum>& datum_vector) {
  CHECK(!has_new_data_) <<
      "Can't add Datum when earlier ones haven't been consumed"
      << " by the upper layers";
  size_t num = datum_vector.size();
  CHECK_GT(num, 0) << "There is no datum to add";
  CHECK_LE(num, batch_size_) <<
      "The number of added datum must be no greater than the batch size";

  // Apply data transformations (mirror, scale, crop...)
  this->data_transformer_.Transform(datum_vector, &added_data_);
  // Copy Labels
  Dtype* top_label = added_label_.mutable_cpu_data();
  for (int item_id = 0; item_id < num; ++item_id) {
    top_label[item_id] = datum_vector[item_id].label();
  }
  // num_images == batch_size_
  Dtype* top_data = added_data_.mutable_cpu_data();

  Dtype* top_data_dim = added_data_dim_.mutable_cpu_data(); // Martin Kersner, 2016/04/06
  int top_data_dim_offset;
  for (int item_id = 0; item_id < batch_size_; ++item_id) {
    top_data_dim_offset = this->added_data_dim_.offset(item_id);
    top_data_dim[top_data_dim_offset]     = static_cast<Dtype>(height_);
    top_data_dim[top_data_dim_offset + 1] = static_cast<Dtype>(width_);
  }

  Reset(top_data, top_label, top_data_dim, batch_size_); // Martin Kersner, 2016/04/19
  //Reset(top_data, top_label, batch_size_);
  has_new_data_ = true;
}

template <typename Dtype>
//void MemoryDataLayer<Dtype>::Reset(Dtype* data, Dtype* labels, int n) {
void MemoryDataLayer<Dtype>::Reset(Dtype* data, Dtype* labels, Dtype* data_dim, int n) { // Martin Kersner, 2016/04/06
  CHECK(data);
  CHECK(labels);
  CHECK(data_dim); // Martin Kersner, 2016/04/06
  CHECK_EQ(n % batch_size_, 0) << "n must be a multiple of batch size";
  data_ = data;
  labels_ = labels;
  data_dim_ = data_dim; // Martin Kersner, 2016/04/06
  n_ = n;
  pos_ = 0;
}

template <typename Dtype>
void MemoryDataLayer<Dtype>::Forward_cpu(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top) {
  CHECK(data_) << "MemoryDataLayer needs to be initalized by calling Reset";
  top[0]->set_cpu_data(data_ + pos_ * size_);
  top[1]->set_cpu_data(labels_ + pos_);
  top[2]->set_cpu_data(data_dim_ + pos_ * 2); // Martin Kersner, 2016/04/06
  pos_ = (pos_ + batch_size_) % n_;
  has_new_data_ = false;
}

INSTANTIATE_CLASS(MemoryDataLayer);
REGISTER_LAYER_CLASS(MEMORY_DATA, MemoryDataLayer);
}  // namespace caffe
