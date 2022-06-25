import os
import sys

sys.path.append("build")
from visiontasks.pyboostcvconverter.utils.aligner import FaceAligner


def get_face_aligner():

    aligner_fn_file = os.path.abspath(os.path.dirname(__file__)) + '/facemodel'
    aligner = FaceAligner(aligner_fn_file)

    return aligner
