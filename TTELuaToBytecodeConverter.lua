-- @hailtt_e

function _G.LuaToBytecode(String)
    local Output = ""
    for Index = 1, string.len(String) do
        Output = Output .. "\\" .. string.byte(string.sub(String, Index, Index))
    end
    print(Output)
    return Output
end

_G.LuaToBytecode()