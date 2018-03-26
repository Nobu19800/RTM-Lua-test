#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- Python -*-

"""
 @file measure_pythonTest.py
 @brief measurement of the processing time
 @date $Date$

 @author n-miyamoto@aist.go.jp

 MIT

"""
import sys
import time
sys.path.append(".")

# Import RTM module
import RTC
import OpenRTM_aist

import echo_idl

# Import Service implementation class
# <rtc-template block="service_impl">

# </rtc-template>

# Import Service stub modules
# <rtc-template block="consumer_import">
import _GlobalIDL, _GlobalIDL__POA


# </rtc-template>


# This module's spesification
# <rtc-template block="module_spec">
measure_pythontest_spec = ["implementation_id", "measure_pythonTest", 
		 "type_name",         "measure_pythonTest", 
		 "description",       "measurement of the processing time", 
		 "version",           "1.0.0", 
		 "vendor",            "Nobuhiko Miyamoto", 
		 "category",          "Sample", 
		 "activity_type",     "STATIC", 
		 "max_instance",      "1", 
		 "language",          "Python", 
		 "lang_type",         "SCRIPT",
		 "conf.default.ior_str", "0",
		 "conf.default.exe_enable", "0",
		 "conf.default.max_count", "1000",

		 "conf.__widget__.ior_str", "text",
		 "conf.__widget__.exe_enable", "radio",
		 "conf.__widget__.max_count", "text",
		 "conf.__constraints__.exe_enable", "(0,1)",

         "conf.__type__.ior_str", "string",
         "conf.__type__.exe_enable", "int",
         "conf.__type__.max_count", "int",

		 ""]
# </rtc-template>

##
# @class measure_pythonTest
# @brief measurement of the processing time
# 
# 処理時間計測用RTC
# 
# 
class measure_pythonTest(OpenRTM_aist.DataFlowComponentBase):
	
	##
	# @brief constructor
	# @param manager Maneger Object
	# 
	def __init__(self, manager):
		OpenRTM_aist.DataFlowComponentBase.__init__(self, manager)


		"""
		"""
		self._servicePort = OpenRTM_aist.CorbaPort("service")

		"""
		"""
		self._interface = Echo_i()
		


		# initialize of configuration-data.
		# <rtc-template block="init_conf_param">
		"""
		起動直後にonInitialize関数から別プロセスにCORBA通信により通知を行うためのIOR
		文字列
		 - Name: ior_str ior_str
		 - DefaultValue: 0
		"""
		self._ior_str = ['0']
		"""
		0：onExecute関数では何もしない
		1：onExecute関数内で10000回の矩形当たり判定を行う
		 - Name: exe_enable exe_enable
		 - DefaultValue: 0
		"""
		self._exe_enable = [0]
		"""
		onExecute関数呼び出し回数。設定回数を超えるとエラーに遷移。
		 - Name: max_count max_count
		 - DefaultValue: 1000
		"""
		self._max_count = [1000]
		
		# </rtc-template>


		 
	##
	#
	# The initialize action (on CREATED->ALIVE transition)
	# formaer rtc_init_entry() 
	# 
	# @return RTC::ReturnCode_t
	# 
	#
	def onInitialize(self):
		# Bind variables and configuration variable
		self.bindParameter("ior_str", self._ior_str, "0")
		self.bindParameter("exe_enable", self._exe_enable, "0")
		self.bindParameter("max_count", self._max_count, "1000")
		
		# Set InPort buffers
		
		# Set OutPort buffers
		
		# Set service provider to Ports
		self._servicePort.registerProvider("interface", "Echo", self._interface)
		
		# Set service consumers to Ports
		
		# Set CORBA Service Ports
		self.addPort(self._servicePort)
		
		return RTC.RTC_OK
	
	#	##
	#	# 
	#	# The finalize action (on ALIVE->END transition)
	#	# formaer rtc_exiting_entry()
	#	# 
	#	# @return RTC::ReturnCode_t
	#
	#	# 
	#def onFinalize(self):
	#
	#	return RTC.RTC_OK
	
	#	##
	#	#
	#	# The startup action when ExecutionContext startup
	#	# former rtc_starting_entry()
	#	# 
	#	# @param ec_id target ExecutionContext Id
	#	#
	#	# @return RTC::ReturnCode_t
	#	#
	#	#
	#def onStartup(self, ec_id):
	#
	#	return RTC.RTC_OK
	
	#	##
	#	#
	#	# The shutdown action when ExecutionContext stop
	#	# former rtc_stopping_entry()
	#	#
	#	# @param ec_id target ExecutionContext Id
	#	#
	#	# @return RTC::ReturnCode_t
	#	#
	#	#
	#def onShutdown(self, ec_id):
	#
	#	return RTC.RTC_OK
	
		##
		#
		# The activated action (Active state entry action)
		# former rtc_active_entry()
		#
		# @param ec_id target ExecutionContext Id
		# 
		# @return RTC::ReturnCode_t
		#
		#
	def onActivated(self, ec_id):
	
		return RTC.RTC_OK
	
		##
		#
		# The deactivated action (Active state exit action)
		# former rtc_active_exit()
		#
		# @param ec_id target ExecutionContext Id
		#
		# @return RTC::ReturnCode_t
		#
		#
	def onDeactivated(self, ec_id):
	
		return RTC.RTC_OK
	
		##
		#
		# The execution action that is invoked periodically
		# former rtc_active_do()
		#
		# @param ec_id target ExecutionContext Id
		#
		# @return RTC::ReturnCode_t
		#
		#
	def onExecute(self, ec_id):
	
		return RTC.RTC_OK
	
	#	##
	#	#
	#	# The aborting action when main logic error occurred.
	#	# former rtc_aborting_entry()
	#	#
	#	# @param ec_id target ExecutionContext Id
	#	#
	#	# @return RTC::ReturnCode_t
	#	#
	#	#
	#def onAborting(self, ec_id):
	#
	#	return RTC.RTC_OK
	
	#	##
	#	#
	#	# The error action in ERROR state
	#	# former rtc_error_do()
	#	#
	#	# @param ec_id target ExecutionContext Id
	#	#
	#	# @return RTC::ReturnCode_t
	#	#
	#	#
	#def onError(self, ec_id):
	#
	#	return RTC.RTC_OK
	
	#	##
	#	#
	#	# The reset action that is invoked resetting
	#	# This is same but different the former rtc_init_entry()
	#	#
	#	# @param ec_id target ExecutionContext Id
	#	#
	#	# @return RTC::ReturnCode_t
	#	#
	#	#
	#def onReset(self, ec_id):
	#
	#	return RTC.RTC_OK
	
	#	##
	#	#
	#	# The state update action that is invoked after onExecute() action
	#	# no corresponding operation exists in OpenRTm-aist-0.2.0
	#	#
	#	# @param ec_id target ExecutionContext Id
	#	#
	#	# @return RTC::ReturnCode_t
	#	#

	#	#
	#def onStateUpdate(self, ec_id):
	#
	#	return RTC.RTC_OK
	
	#	##
	#	#
	#	# The action that is invoked when execution context's rate is changed
	#	# no corresponding operation exists in OpenRTm-aist-0.2.0
	#	#
	#	# @param ec_id target ExecutionContext Id
	#	#
	#	# @return RTC::ReturnCode_t
	#	#
	#	#
	#def onRateChanged(self, ec_id):
	#
	#	return RTC.RTC_OK
	



def measure_pythonTestInit(manager):
    profile = OpenRTM_aist.Properties(defaults_str=measure_pythontest_spec)
    manager.registerFactory(profile,
                            measure_pythonTest,
                            OpenRTM_aist.Delete)

def MyModuleInit(manager):
    measure_pythonTestInit(manager)

    # Create a component
    comp = manager.createComponent("measure_pythonTest")

def main():
	mgr = OpenRTM_aist.Manager.init(sys.argv)
	mgr.setModuleInitProc(MyModuleInit)
	mgr.activateManager()
	mgr.runManager()

if __name__ == "__main__":
	main()

