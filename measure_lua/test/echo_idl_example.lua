local openrtm  = require "openrtm"


--[[
 @file echo_idl_examplefile.py
 @brief Lua example implementations generated from echo.idl
 @date $Date$

 @author n-miyamoto@aist.go.jp

 MIT

--]]


local echo_idl_example = {}



echo_idl_example.Echo_i = {}
echo_idl_example.Echo_i.new = function()
    --[[
    @class Echo_i
    Example class implementing IDL interface Echo
    --]]
    local obj = {}

    --[[
    @brief standard constructor
    Initialise member variables here
    --]]

    -- string echoString(in ${luaConv.convCORBA2LuathonArg(${serviceArgumentParam.type})} mesg)
    function obj:echoString(mesg)
        error(openrtm.Manager:getORB():newexcept{"CORBA::NO_IMPLEMENT",
              minor=0,
              completed=openrtm.Manager:getORB().types:lookup("::CORBA::CompletionStatus").labelvalue.COMPLETED_NO})
        -- *** Implement me
        -- Must return: result
    end

    return obj
end

if openrtm.Manager.is_main() then
    
    local oil = require "oil"
    oil.main(function()
        -- Initialise the ORB
        local orb = oil.init{ flavor = "cooperative;corba;intercepted;typed;base;" }

        oil.newthread(self._orb.run, self._orb)

        -- Create an instance of a servant class
        local obj = echo_idl_example.Echo_i.new()
        local servant = orb:newservant(obj, nil, "IDL:Echo:1.0")



        -- Get the object reference to the object
        local objref = openrtm.RTCUtil.getReference()
    
        -- Print a stringified IOR for it
        print(orb:tostring(servant))

        -- Run the ORB, blocking this thread
        orb:run()
    end)
end

return echo_idl_example
