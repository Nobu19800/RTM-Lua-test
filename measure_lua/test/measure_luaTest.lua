---------------------------------
--! @file measure_luaTest.py
--! @brief measurement of the processing time
--! @date $Date$

--! @author ${tmpltHelperPy.convertAuthorDocPy(${rtcParam.docCreator})}

--! ${tmpltHelperPy.convertDocPy(${rtcParam.docLicense})}
---------------------------------

local openrtm  = require "openrtm"



-- Import Service implementation class
-- <rtc-template block="service_impl">
local echo_idl_example = require "echo_idl_example"


-- </rtc-template>


-- This module's spesification
-- <rtc-template block="module_spec">
local measure_luatest_spec = {["implementation_id"]="measure_luaTest", 
		 ["type_name"[="measure_luaTest", 
		 ["description"]="measurement of the processing time",
		 ["version"]="1.0.0",
		 ["vendor"]="Nobuhiko Miyamoto",
		 ["category"]="Sample",
		 ["activity_type"]="STATIC",
		 ["max_instance"]="1",
		 ["language"]="Lua",
		 ["lang_type"]="SCRIPT",
		 ["conf.default.ior_str"]="0",
		 ["conf.default.exe_enable"]="0",
		 ["conf.default.max_count"]="1000",
		 ["conf.__widget__.ior_str"]="text",
		 ["conf.__widget__.exe_enable"]="radio",
		 ["conf.__widget__.max_count"]="text",
		 ["conf.__constraints__.exe_enable"]="(0,1)",
         ["conf.__type__.ior_str"]="string",
         ["conf.__type__.exe_enable"]="int",
         ["conf.__type__.max_count"]="int",
		 ""}
-- </rtc-template>

-- @class measure_luaTest
-- @brief measurement of the processing time
--
-- 処理時間計測用RTC
local measure_luaTest = {}
measure_luaTest.new = function(manager)
	local obj = {}
	setmetatable(obj, {__index=openrtm.RTObject.new(manager)})




	--[[
	--]]
	obj._servicePort = openrtm.CorbaPort.new("service")

	--[[
	--]]
	obj._interface = echo_idl_example.Echo_i.new()



	-- initialize of configuration-data.
	-- <rtc-template block="init_conf_param">
	--[[
		起動直後にonInitialize関数から別プロセスにCORBA通信により通知を行うためのIOR
		文字列
		 - Name: ior_str ior_str
		 - DefaultValue: 0
	--]]
	obj._ior_str = {_value='0'}
	--[[
		0：onExecute関数では何もしない
		1：onExecute関数内で10000回の矩形当たり判定を行う
		 - Name: exe_enable exe_enable
		 - DefaultValue: 0
	--]]
	obj._exe_enable = {_value=0}
	--[[
		onExecute関数呼び出し回数。設定回数を超えるとエラーに遷移。
		 - Name: max_count max_count
		 - DefaultValue: 1000
	--]]
	obj._max_count = {_value=1000}

	-- </rtc-template>
		 
	--
	-- The initialize action (on CREATED->ALIVE transition)
	-- formaer rtc_init_entry()
	--
	-- @return RTC::ReturnCode_t
	--
	--
	function obj:onInitialize()
		-- Bind variables and configuration variable
		self:bindParameter("ior_str", self._ior_str, "0")
		self:bindParameter("exe_enable", self._exe_enable, "0")
		self:bindParameter("max_count", self._max_count, "1000")

		-- Set OutPort buffers

		-- Set InPort buffers

		-- Set service provider to Ports
		self._servicePort:registerProvider("interface", "Echo", self._interface, "idl/echo.idl", "IDL:Echo:1.0")

		-- Set service consumers to Ports

		-- Set CORBA Service Ports
		self:addPort(self._servicePort)

		return self._ReturnCode_t.RTC_OK
	end

	--	--
	--	-- The finalize action (on ALIVE->END transition)
	--	-- formaer rtc_exiting_entry()
	--	--
	--	-- @return RTC::ReturnCode_t
	--
	--	--
	--	funtion obj:onFinalize()
	--
	--	return self._ReturnCode_t.RTC_OK
	--	end

	--	--
	--	-- The startup action when ExecutionContext startup
	--	-- former rtc_starting_entry()
	--	--
	--	-- @param ec_id target ExecutionContext Id
	--	--
	--	-- @return RTC::ReturnCode_t
	--	--
	--	--
	--	function obj:onStartup(ec_id)
	--	
	--		return self._ReturnCode_t.RTC_OK
	--	end

	--	--
	--	-- The shutdown action when ExecutionContext stop
	--	-- former rtc_stopping_entry()
	--	--
	--	-- @param ec_id target ExecutionContext Id
	--	--
	--	-- @return RTC::ReturnCode_t
	--	--
	--	--
	--	function obj:onShutdown(ec_id)
	--	
	--		return self._ReturnCode_t.RTC_OK
	--	end

	--
	-- The activated action (Active state entry action)
	-- former rtc_active_entry()
	--
	-- @param ec_id target ExecutionContext Id
	--
	-- @return RTC::ReturnCode_t
	--
	--
	function obj:onActivated(ec_id)
	
		return self._ReturnCode_t.RTC_OK
	end

	--
	-- The deactivated action (Active state exit action)
	-- former rtc_active_exit()
	--
	-- @param ec_id target ExecutionContext Id
	--
	-- @return RTC::ReturnCode_t
	--
	--
	function obj:onDeactivated(ec_id)
	
		return self._ReturnCode_t.RTC_OK
	end

	--
	-- The execution action that is invoked periodically
	-- former rtc_active_do()
	--
	-- @param ec_id target ExecutionContext Id
	--
	-- @return RTC::ReturnCode_t
	--
	--
	function obj:onExecute(ec_id)
	
		return self._ReturnCode_t.RTC_OK
	end

	--	--
	--	-- The aborting action when main logic error occurred.
	--	-- former rtc_aborting_entry()
	--	--
	--	-- @param ec_id target ExecutionContext Id
	--	--
	--	-- @return RTC::ReturnCode_t
	--	--
	--	--
	--	function obj:onAborting(ec_id)
	--	
	--	return self._ReturnCode_t.RTC_OK
	--end

	--	--
	--	-- The error action in ERROR state
	--	-- former rtc_error_do()
	--	--
	--	-- @param ec_id target ExecutionContext Id
	--	--
	--	-- @return RTC::ReturnCode_t
	--	--
	--	--
	--	function obj:onError(ec_id)
	--	
	--		return self._ReturnCode_t.RTC_OK
	--	end

	--	--
	--	-- The reset action that is invoked resetting
	--	-- This is same but different the former rtc_init_entry()
	--	--
	--	-- @param ec_id target ExecutionContext Id
	--	--
	--	-- @return RTC::ReturnCode_t
	--	--
	--	--
	--	function obj:onReset(ec_id)
	--	
	--		return self._ReturnCode_t.RTC_OK
	--	end

	--	--
	--	-- The state update action that is invoked after onExecute() action
	--	-- no corresponding operation exists in OpenRTm-aist-0.2.0
	--	--
	--	-- @param ec_id target ExecutionContext Id
	--	--
	--	-- @return RTC::ReturnCode_t
	--	--

	--	--
	--	function obj:onStateUpdate(ec_id)
	--	
	--		return self._ReturnCode_t.RTC_OK
	--	end

	--	--
	--	-- The action that is invoked when execution context's rate is changed
	--	-- no corresponding operation exists in OpenRTm-aist-0.2.0
	--	--
	--	-- @param ec_id target ExecutionContext Id
	--	--
	--	-- @return RTC::ReturnCode_t
	--	--
	--	--
	--	function obj:onRateChanged(ec_id)
	--	
	--		return self._ReturnCode_t.RTC_OK
	--	end
	return obj
end


local MyModuleInit = function(manager)
    measure_luaTest.Init(manager)

    -- Create a component
    local comp = manager:createComponent("measure_luaTest")
end

if openrtm.Manager.is_main() then
	local manager = openrtm.Manager
	manager:init(arg)
	manager:setModuleInitProc(MyModuleInit)
	manager:activateManager()
	manager:runManager()
else
	return measure_luaTest
end

