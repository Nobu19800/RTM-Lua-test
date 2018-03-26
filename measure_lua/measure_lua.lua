---------------------------------
--! @file measure_lua.lua
--! @brief measurement of the processing time
--! @date $Date$
--! @author n-miyamoto@aist.go.jp
--! MIT
---------------------------------



-- Import RTM module
local openrtm  = require "openrtm"



-- Import Service implementation class
-- <rtc-template block="service_impl">







-- </rtc-template>


-- This module's spesification
-- <rtc-template block="module_spec">
-- This module's spesification
-- <rtc-template block="module_spec">
local measure_lua_spec = {["implementation_id"]="measure_lua",
		 ["type_name"]="measure_lua",
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


-- @class measure_lua
-- @brief measurement of the processing time
--
-- 処理時間計測用RTC
local measure_lua = {}
measure_lua.new = function(manager)
	local obj = {}
	setmetatable(obj, {__index=openrtm.RTObject.new(manager)})





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

		-- Set service consumers to Ports
		

		-- Set CORBA Service Ports
		
		
		if #self._ior_str._value > 10 then
			local fpath = openrtm.StringUtil.dirname(string.sub(debug.getinfo(1)["source"],2))
			openrtm.Manager:loadIdLFile(string.gsub(fpath,"\\","/").."/idl/echo.idl")
			local _obj = openrtm.RTCUtil.newproxy(self._orb, self._ior_str._value,"IDL:Echo:1.0")
			_obj:echoString("")
		end

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
		self.chrs = {}
		for i = 1, 10000 do
			local chr = {width=10, height=10}
			chr.pos_x = math.random(-1000, 1000)
			chr.pos_y = math.random(-1000, 1000)
			self.chrs[tostring(i)] = chr
		end
		
		self.write_file = io.open("lua_test.dat", "a")
		self.start_time = os.clock()
		self.mesure_count = 0
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
		self.write_file:write(tostring(os.clock()-self.start_time.."\n"))
		self.write_file:close()
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
		local player = {width=10,height=10,pos_x=0,pos_y=0}

		if self._exe_enable._value == 1 then

			for k,tmp_chr in pairs(self.chrs) do

				if math.abs(player.pos_x - tmp_chr.pos_x) < (player.width / 2 + tmp_chr.width/2) then

					if math.abs(player.pos_y - tmp_chr.pos_y) < (player.height / 2 + tmp_chr.height/2) then

						if player.pos_x < tmp_chr.pos_x then
							player.pos_x = player.pos_x + 1
						elseif player.pos_x > tmp_chr.pos_x then
							player.pos_x = player.pos_x - 1
						end
						if player.pos_y < tmp_chr.pos_y then
							player.pos_y = player.pos_y + 1
						elseif player.pos_y > tmp_chr.pos_y then
							player.pos_y = player.pos_y - 1
						end
					end
				end
			end
		end
		if self.mesure_count > self._max_count._value then
			return self._ReturnCode_t.RTC_ERROR
		end
		self.mesure_count = self.mesure_count+1
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



measure_lua.Init = function(manager)
    local profile = openrtm.Properties.new{defaults_map=measure_lua_spec}
    manager:registerFactory(profile,
                            measure_lua.new,
                            openrtm.Factory.Delete)
end

local MyModuleInit = function(manager)
    measure_lua.Init(manager)

    -- Create a component
    local comp = manager:createComponent("measure_lua")
end

if openrtm.Manager.is_main() then
	local manager = openrtm.Manager
	manager:init(arg)
	manager:setModuleInitProc(MyModuleInit)
	manager:activateManager()
	manager:runManager()
else
	return measure_lua
end

