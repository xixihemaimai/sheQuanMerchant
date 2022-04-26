#coding: utf-8

import os
import sys

root = os.getcwd()
gen = '%s/gen' % root
if os.path.exists('gen'):
    os.system('rm -rf gen')
os.mkdir('gen')

gs = []


def list_g(dir):
    gs.append(dir)
    p = '%s/%s' % (root, dir)
    for g in os.listdir(p):
        t = dir + '/' + g
        if os.path.isdir(t):
            list_g(t)


list_g('protos')


def compile_pb(g):
    t = '%s/%s' % (gen, g)
    os.mkdir(t)
    os.chdir(root+'/'+g)
    os.system('protoc --objc_out="%s" *.proto --experimental_allow_proto3_optional' % (t))

print(gs)
for g in gs:
    compile_pb(g)
