#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- Python -*-

import subprocess
import os
import time

import sys
from omniORB import CORBA, PortableServer
import _GlobalIDL, _GlobalIDL__POA


class Echo_i (_GlobalIDL__POA.Echo):
    def __init__(self, start, filename):
        self._start_time = start
        self._filename = filename
    def echoString(self, mesg):
        ret = time.time() - self._start_time
        print(ret)
        with open(self._filename,'a') as f:
            f.write(str(ret)+"\n")
          
        return mesg

if __name__ == "__main__":
  if len(sys.argv) < 2:
      sys.argv.append("python")
  lang = sys.argv[1]
  del sys.argv[1]
  
  orb = CORBA.ORB_init(sys.argv, CORBA.ORB_ID)
  poa = orb.resolve_initial_references("RootPOA")
  #ei = Echo_i(time.time(), "python.dat")
  #ei = Echo_i(time.time(), "lua.dat")
  #ei = Echo_i(time.time(), "luajit.dat")
  #ei = Echo_i(time.time(), "cpp.dat")
  ei = Echo_i(time.time(), lang+".dat")
  eo = ei._this()
  ior = orb.object_to_string(eo)
  poaManager = poa._get_the_POAManager()
  poaManager.activate()

  if lang == "python":
      com = "python measure_python/measure_python.py -o Sample.measure_python0.conf.default.ior_str:" + ior
  elif lang == "lua":
      if os.name == 'posix':
          com = "lua measure_lua/measure_lua.lua -o Sample.measure_lua0.conf.default.ior_str:" + ior
      elif os.name == 'nt':
          com = "\"openrtm-lua-0.2.0(x64)\\bin\\lua\" measure_lua/measure_lua.lua -o Sample.measure_lua0.conf.default.ior_str:" + ior
  elif lang == "luajit":
      if os.name == 'posix':
          com = "luajit measure_luajit/measure_luajit.lua -o Sample.measure_luajit0.conf.default.ior_str:" + ior
      elif os.name == 'nt':
          com = "\"openrtm-lua-0.2.0(LuaJITx64)\\bin\\luajit\" measure_luajit/measure_luajit.lua -o Sample.measure_luajit0.conf.default.ior_str:" + ior
  else:
      if os.name == 'posix':
          com = "measure_cpp/build/src/measure_cppComp -o Sample.measure_cpp0.conf.default.ior_str:" + ior
      elif os.name == 'nt':
          com = "measure_cpp\\build\\src\\Release\\measure_cppComp -o Sample.measure_cpp0.conf.default.ior_str:" + ior

  if os.name == 'posix':
    com = com.split(" ")
  elif os.name == 'nt':
    pass
    
  ei._start_time = time.time()
  sp = subprocess.Popen(com, stdin=subprocess.PIPE)
  orb.run()
  #sp.kill()