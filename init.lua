-- Cycle windows when clicking an already-active app in the Dock.
local dockClickTap

local function getDockItemAt(point)
    local ok, element = pcall(
        hs.axuielement.systemElementAtPosition,
        point
    )
    if not ok or not element then return nil end

    local okRole, role = pcall(function()
        return element:attributeValue("AXRole")
    end)
    local okTitle, title = pcall(function()
        return element:attributeValue("AXTitle")
    end)

    if okRole and role == "AXDockItem" and okTitle then
        return title
    end
    return nil
end

local function cycleWindow(appName)
    local app = hs.application.get(appName)
    if not app then
        print("Dock cycle: app not found:", appName)
        return
    end

    local windows = {}
    for _, win in ipairs(app:allWindows()) do
        if win and not win:isMinimized() then
            table.insert(windows, win)
        end
    end

    print("Dock cycle:", appName, "windows:", #windows)

    if #windows < 2 then return end

    local focused = hs.window.focusedWindow()
    local currentIndex = nil

    if focused then
        for i, win in ipairs(windows) do
            if win:id() == focused:id() then
                currentIndex = i
                break
            end
        end
    end

    local nextIndex
    if currentIndex then
        nextIndex = (currentIndex % #windows) + 1
    else
        nextIndex = 1
    end

    print("Dock cycle: focusing window", windows[nextIndex]:id())
    windows[nextIndex]:focus()
end

if dockClickTap then
    dockClickTap:stop()
end

dockClickTap = hs.eventtap.new({
    hs.eventtap.event.types.leftMouseDown
}, function(event)
    local appName = getDockItemAt(event:location())
    if not appName then return false end

    local frontApp = hs.application.frontmostApplication()

    if frontApp and frontApp:name() == appName then
        hs.timer.doAfter(0.25, function()
            cycleWindow(appName)
        end)
    end

    return false
end)

dockClickTap:start()
print("Dock window cycling enabled.")
