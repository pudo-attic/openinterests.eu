import os
from os import path as osp

DATA_DIR = osp.realpath(osp.join(osp.dirname(__file__), '../../data/'))

def reference_data_path(sub_path):
	return osp.join(DATA_DIR, sub_path)