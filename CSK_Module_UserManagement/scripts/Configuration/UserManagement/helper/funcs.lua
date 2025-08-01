---@diagnostic disable: undefined-global, redundant-parameter, missing-parameter
--*****************************************************************
-- Inside of this script, you will find helper functions
--*****************************************************************

--**************************************************************************
--**********************Start Global Scope *********************************
--**************************************************************************

local funcs = {}
-- Providing standard JSON functions
funcs.json = require('Configuration/UserManagement/helper/Json')

--**************************************************************************
--********************** End Global Scope **********************************
--**************************************************************************
--**********************Start Function Scope *******************************
--**************************************************************************

--- Function to get content list of users as JSON string
---@param data string[] Table with data entries
---@param selectedRow int Currently selected row
---@return string sortedTable Sorted entries as JSON string
local function createUserJsonList(data, selectedRow)
  local sortedTable = {}
  for key, value in pairs(data) do
    table.insert(sortedTable, value)
  end
  table.sort(sortedTable)

  local endList = {}

  for key, value in pairs(sortedTable) do
    local isSelected = false
      if value == selectedRow then
        isSelected = true
      end
      table.insert(endList, {User = tostring(value), selected = isSelected})
  end
  return funcs.json.encode(endList)
end
funcs.createUserJsonList = createUserJsonList

--- Function to create a list with numbers
---@param size number Size of the list
---@return string list List of numbers
local function createStringListBySize(size)
  local list = "["
  if size >= 1 then
    list = list .. '"' .. tostring(1) .. '"'
  end
  if size >= 2 then
    for i=2, size do
      list = list .. ', ' .. '"' .. tostring(i) .. '"'
    end
  end
  list = list .. "]"
  return list
end
funcs.createStringListBySize = createStringListBySize

--- Function to convert a table into a Container object
---@param content auto[] Lua Table to convert to Container
---@return Container cont Created Container
local function convertTable2Container(content)
  local cont = Container.create()
  for key, value in pairs(content) do
    if type(value) == 'table' then
      cont:add(key, convertTable2Container(value), nil)
    else
      cont:add(key, value, nil)
    end
  end
  return cont
end
funcs.convertTable2Container = convertTable2Container

--- Function to convert a Container into a table
---@param cont Container Container to convert to Lua table
---@return auto[] data Created Lua table
local function convertContainer2Table(cont)
  local data = {}
  local containerList = Container.list(cont)
  local containerCheck = false
  if tonumber(containerList[1]) then
    containerCheck = true
  end
  for i=1, #containerList do

    local subContainer

    if containerCheck then
      subContainer = Container.get(cont, tostring(i) .. '.00')
    else
      subContainer = Container.get(cont, containerList[i])
    end
    if type(subContainer) == 'userdata' then
      if Object.getType(subContainer) == "Container" then

        if containerCheck then
          table.insert(data, convertContainer2Table(subContainer))
        else
          data[containerList[i]] = convertContainer2Table(subContainer)
        end

      else
        if containerCheck then
          table.insert(data, subContainer)
        else
          data[containerList[i]] = subContainer
        end
      end
    else
      if containerCheck then
        table.insert(data, subContainer)
      else
        data[containerList[i]] = subContainer
      end
    end
  end
  return data
end
funcs.convertContainer2Table = convertContainer2Table

--- Function to get content list out of table
---@param data string[] Table with data entries
---@return string sortedTable Sorted entries as string, internally seperated by ','
local function createContentList(data)
  local sortedTable = {}
  for key, _ in pairs(data) do
    table.insert(sortedTable, key)
  end
  table.sort(sortedTable)
  return table.concat(sortedTable, ',')
end
funcs.createContentList = createContentList

--- Function to get content list as JSON string
---@param data string[] Table with data entries
---@return string resultTable Sorted entries as JSON string
local function createJsonList(data)
  local sortedTable = {}
  local resultTable = {}
  for _, valueA in pairs(data) do
    table.insert(sortedTable, valueA)
  end
  table.sort(sortedTable)
  for _, value in ipairs(sortedTable) do
    table.insert(resultTable, {User = value})
  end
  return funcs.json.encode(resultTable)
end
funcs.createJsonList = createJsonList

--- Function to create a JSON string for dynamic table in UI
---@param content string[] Table with data entries
---@return string jsonstring String list
local function createJsonListForTableView(content)
  local orderedTable = {}
  local parameterList = {}

  if content ~= nil then
    for n in pairs(content) do
      table.insert(orderedTable, n)
    end
    table.sort(orderedTable)
    for _, value in ipairs(orderedTable) do

      if type(content[value]) == 'table' then
        local orderedSubTable = {}
        for m in pairs(content[value]) do
          table.insert(orderedSubTable, m)
        end
        table.sort(orderedSubTable)

        for _, subValue in ipairs(orderedSubTable) do
          table.insert(parameterList, {ParameterName = value .. ' // ' .. tostring(subValue), Value = tostring(content[value][subValue])})
        end
      else
        table.insert(parameterList, {ParameterName = value, Value = tostring(content[value])})
      end
    end
  end

  if #parameterList == 0 then
    parameterList = {{ParameterName = '-', Value = '-'},}
  end

  local jsonstring = funcs.json.encode(parameterList)
  return jsonstring
end
funcs.createJsonListForTableView = createJsonListForTableView

--- Function to create a list from table
---@param content string[] Table with data entries
---@return string list String list
local function createStringListBySimpleTable(content)
  local list = "["
  if #content >= 1 then
    list = list .. '"' .. content[1] .. '"'
  end
  if #content >= 2 then
    for i=2, #content do
      list = list .. ', ' .. '"' .. content[i] .. '"'
    end
  end
  list = list .. "]"
  return list
end
funcs.createStringListBySimpleTable = createStringListBySimpleTable

return funcs

--**************************************************************************
--**********************End Function Scope *********************************
--**************************************************************************