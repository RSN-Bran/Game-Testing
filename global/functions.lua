DEBUG = true

function calculateDistance(position1, position2)
    xDistance = (position2.x - position1.x)^2
    yDistance = (position2.y - position1.y)^2
    return math.sqrt(xDistance+yDistance)
end

function contains (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function removeValue(tab, val)

    for index, value in ipairs(tab) do
        if value == val then
            table.remove(tab, index)
        end
    end

end

function isempty(s)
    return s == nil or s == ''
end

function printTableKeys(tab)
    for k,v in pairs(tab) do
        print(k)
    end
end

function increment(val, inc)
    return val + inc
end

function dumpTable(table, depth)
    if (depth > 200) then
      print("Error: Depth > 200 in dumpTable()")
      return
    end
    for k,v in pairs(table) do
      if (type(v) == "table") then
        print(string.rep("  ", depth)..k..":")
        dumpTable(v, depth+1)
      else
        print(string.rep("  ", depth)..k..": ",v)
      end
    end
  end