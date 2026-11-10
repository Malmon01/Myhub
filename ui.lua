-- Place this LocalScript in StarterPlayerScripts.
-- Replace these sample catalogs with the data for your experience.
local catalog = {
	[12] = {eggs = {"Luna Egg", "Fairy Egg", "Phoenix Egg", "Crystal Egg", "Royal Dragon Egg"},
		animals = {"Shadowgale"}},
	[13] = {eggs = {"Castle Egg", "Cracked Egg", "Lion Egg"},
		animals = {"CastleCrab", "CastleCroc", "Beholder"}},
}
local buffOptions = {"บัพตัวอย่าง A", "บัพตัวอย่าง B"}
local tweenSpeed = 300
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local ink = Color3.fromRGB(237, 244, 234)
local muted = Color3.fromRGB(164, 179, 175)
local surface = Color3.fromRGB(34, 47, 48)
local lime = Color3.fromRGB(208, 250, 114)
local dark = Color3.fromRGB(18, 26, 26)

local function make(class, parent, properties)
	local instance = Instance.new(class)
	for key, value in pairs(properties) do instance[key] = value end
	instance.Parent = parent
	return instance
end

local function round(instance, radius)
	make("UICorner", instance, {CornerRadius = UDim.new(0, radius)})
end

local function label(parent, value, size)
	return make("TextLabel", parent, {
		BackgroundTransparency = 1, Text = value, TextColor3 = ink, TextSize = size,
		Font = Enum.Font.Gotham, TextXAlignment = Enum.TextXAlignment.Left,
	})
end

local function button(parent, value)
	local result = make("TextButton", parent, {
		BackgroundColor3 = surface, BorderSizePixel = 0, Text = value,
		TextColor3 = ink, TextSize = 14, Font = Enum.Font.GothamMedium,
	})
	round(result, 9)
	return result
end

local gui = make("ScreenGui", nil, {Name = "MyHubStudio", ResetOnSpawn = false, DisplayOrder = 20})
gui:SetAttribute("MyHubStandalonePreview", true)
local actions = make("BindableEvent", gui, {Name = "ActionRequested"})
local panel = make("Frame", gui, {
	AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(560, 420), BackgroundColor3 = dark, BorderSizePixel = 0, Active = true,
})
round(panel, 16)
local scale = make("UIScale", panel, {Scale = 1})
local nav = make("Frame", panel, {
	Position = UDim2.fromOffset(12, 14), Size = UDim2.fromOffset(107, 390),
	BackgroundTransparency = 1,
})
local brand = label(nav, "MYHUB", 17)
brand.Size = UDim2.fromOffset(107, 34)
brand.TextColor3 = lime
local title = label(panel, "ฟาร์ม", 22)
title.Position = UDim2.fromOffset(134, 15)
title.Size = UDim2.fromOffset(330, 36)
local logo = button(panel, "M")
logo.Position = UDim2.new(1, -52, 0, 14)
logo.Size = UDim2.fromOffset(38, 38)
logo.BackgroundColor3, logo.TextColor3 = lime, dark
local reopen = button(gui, "เปิด MYHUB")
reopen.Position = UDim2.fromOffset(14, 78)
reopen.Size = UDim2.fromOffset(116, 36)
reopen.Visible = false
logo.Activated:Connect(function() panel.Visible = false; reopen.Visible = true end)
reopen.Activated:Connect(function() panel.Visible = true; reopen.Visible = false end)

local status = label(panel, "โหมดทดลอง · ข้อมูลตัวอย่าง", 13)
status.Position = UDim2.fromOffset(134, 365)
status.Size = UDim2.fromOffset(410, 42)
status.TextWrapped = true
status.TextColor3 = muted
local pages, tabs = {}, {}
local pageNames = {"ฟาร์ม", "หาตัว", "สวน", "เพิ่ม FPS"}
local function selectPage(index)
	title.Text = pageNames[index]
	for i, page in ipairs(pages) do
		page.Visible = i == index
		tabs[i].BackgroundColor3 = i == index and lime or surface
		tabs[i].TextColor3 = i == index and dark or ink
	end
end
for i, name in ipairs(pageNames) do
	local index = i
	local tab = button(nav, name)
	tab.Position = UDim2.fromOffset(0, 48 + (i - 1) * 49)
	tab.Size = UDim2.fromOffset(107, 41)
	tabs[i] = tab
	tab.Activated:Connect(function() selectPage(index) end)
	local page = make("ScrollingFrame", panel, {
		Position = UDim2.fromOffset(134, 66), Size = UDim2.fromOffset(410, 293),
		BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4,
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y, Visible = false,
	})
	pages[i] = page
	make("UIListLayout", page, {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder})
end

local function row(page, name, height)
	local frame = make("Frame", page, {
		Size = UDim2.new(1, -8, 0, height or 42), LayoutOrder = #page:GetChildren(),
		BackgroundColor3 = surface, BorderSizePixel = 0,
	})
	round(frame, 9)
	local text = label(frame, name, 14)
	text.Position = UDim2.fromOffset(12, 0)
	text.Size = UDim2.new(0.5, -16, 0, 42)
	return frame
end

local function control(instance)
	instance.Position = UDim2.new(0.5, 0, 0, 5)
	instance.Size = UDim2.new(0.5, -8, 0, 32)
	return instance
end

local function toggle(page, name, changed, locked)
	local frame = row(page, name)
	local b = control(button(frame, ""))
	b.AutoButtonColor = not locked
	local enabled = false
	local function set(value)
		enabled = value
		b.Text = enabled and "เปิด" or "ปิด"
		b.BackgroundColor3 = enabled and lime or dark
		b.TextColor3 = enabled and dark or muted
	end
	set(false)
	if not locked then
		b.Activated:Connect(function()
			set(not enabled)
			if changed(enabled) == false then set(false) end
		end)
	end
	return set, function() return enabled end
end

local function field(page, name, placeholder)
	local input = control(make("TextBox", row(page, name), {
		BackgroundColor3 = dark, BorderSizePixel = 0, TextColor3 = ink,
		PlaceholderColor3 = muted, PlaceholderText = placeholder, Text = "",
		TextSize = 14, Font = Enum.Font.Gotham, ClearTextOnFocus = false,
	}))
	round(input, 8)
	return input
end

local function picker(page, name, options, selected, changed, multiple)
	local frame = row(page, name)
	local head = control(button(frame, ""))
	head.BackgroundColor3 = dark
	local entries = make("Frame", frame, {
		Position = UDim2.fromOffset(8, 44), Size = UDim2.new(1, -16, 0, 0),
		BackgroundTransparency = 1, Visible = false,
	})
	make("UIListLayout", entries, {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder})
	local open = false
	local function draw()
		local list, value = options(), selected()
		local count = 0
		if multiple then
			for _, option in ipairs(list) do if value[option] then count = count + 1 end end
		end
		head.Text = multiple and (count == #list and "ทุกชนิด ▾" or "เลือก " .. count .. " ชนิด ▾")
			or tostring(value) .. " ▾"
		for _, item in ipairs(entries:GetChildren()) do if item:IsA("TextButton") then item:Destroy() end end
		entries.Visible = open
		local height = open and #list * 34 or 0
		entries.Size = UDim2.new(1, -16, 0, height)
		frame.Size = UDim2.new(1, -8, 0, 42 + height + (open and 6 or 0))
		if not open then return end
		for i, option in ipairs(list) do
			local key = option
			local checked = multiple and value[key] or value == key
			local b = button(entries, (checked and "✓  " or "") .. key)
			b.LayoutOrder, b.Size = i, UDim2.new(1, 0, 0, 30)
			b.BackgroundColor3 = dark
			b.Activated:Connect(function()
				if not multiple then open = false end
				changed(key)
				draw()
			end)
		end
	end
	head.Activated:Connect(function() open = not open; draw() end)
	draw()
	return function() open = false; draw() end
end

local function parseWeight(text)
	local clean = text:lower():gsub("[%s,]", ""):gsub("kg$", "")
	if clean == "" then return nil, true end
	local digits, unit = clean:match("^([%d.]+)([kmbt]?)$")
	local value = tonumber(digits)
	if not value or value <= 0 then return nil, false end
	local multiplier = ({[""] = 1, k = 1e3, m = 1e6, b = 1e9, t = 1e12})[unit]
	local kg = value * multiplier
	return kg, kg < math.huge
end

local function emit(feature, enabled, config)
	status.Text = "ทดลอง " .. (enabled and "เปิด" or "ปิด") .. feature
	actions:Fire(feature, enabled, config)
end

local zones = {"โซน 12", "โซน 13"}
local farmZone, gardenZone = 12, 12
local farmEggs, gardenEggs = {}, {}
for zone, data in pairs(catalog) do
	farmEggs[zone], gardenEggs[zone] = {}, {}
	for _, egg in ipairs(data.eggs) do farmEggs[zone][egg] = true end
end
local farmPage, huntPage, gardenPage, fpsPage = table.unpack(pages)
local refreshFarmEggs, refreshGardenEggs
picker(farmPage, "เลือกโซน", function() return zones end, function() return "โซน " .. farmZone end, function(value)
	farmZone = tonumber(value:match("%d+"))
	refreshFarmEggs()
end)
local setGems
toggle(farmPage, "เริ่มฟาร์ม", function(enabled)
	setGems(enabled)
	emit("ฟาร์ม", enabled, {zone = farmZone, eggs = table.clone(farmEggs[farmZone]), autoGem = enabled, tweenSpeed = tweenSpeed})
end)
setGems = toggle(farmPage, "เก็บเพชร", function() end, true)
refreshFarmEggs = picker(farmPage, "เลือกไข่", function() return catalog[farmZone].eggs end,
	function() return farmEggs[farmZone] end,
	function(key) farmEggs[farmZone][key] = not farmEggs[farmZone][key] end, true)

local weight = field(huntPage, "เลือกน้ำหนัก", "เช่น 20K หรือ 20k")
local destination, fallback, animal, buff = "ไปจุด AFK", "ไม่เลือก", "ไม่เลือก", "ไม่เลือก"
picker(huntPage, "เลือกปลายทาง", function() return {"ไปจุด AFK", "กลับบ้าน"} end,
	function() return destination end, function(value) destination = value end)
toggle(huntPage, "เริ่มหาตัว", function(enabled)
	local kg, valid = parseWeight(weight.Text)
	if enabled and not valid then status.Text = "กรอกน้ำหนักเป็นตัวเลข เช่น 20K"; return false end
	emit("หาตัว", enabled, {zone = farmZone, weightKg = kg, destination = destination,
		fallback = fallback, animal = animal, buff = buff, tweenSpeed = tweenSpeed})
end)
local function animalOptions()
	local list = {"ไม่เลือก"}
	for _, zone in ipairs({12, 13}) do
		for _, name in ipairs(catalog[zone].animals) do table.insert(list, name) end
	end
	return list
end
picker(huntPage, "เลือกเป็นอันดับ 2", animalOptions, function() return fallback end, function(value) fallback = value end)
picker(huntPage, "เลือกตัวติดบัพ", animalOptions, function() return animal end, function(value) animal = value end)
picker(huntPage, "เลือกบัพ", function()
	local list = table.clone(buffOptions)
	table.insert(list, 1, "ไม่เลือก")
	return list
end, function() return buff end, function(value) buff = value end)

picker(gardenPage, "เลือกโซน", function() return zones end, function() return "โซน " .. gardenZone end, function(value)
	gardenZone = tonumber(value:match("%d+"))
	refreshGardenEggs()
end)
refreshGardenEggs = picker(gardenPage, "เลือกไข่", function() return catalog[gardenZone].eggs end,
	function() return gardenEggs[gardenZone] end,
	function(key) gardenEggs[gardenZone][key] = not gardenEggs[gardenZone][key] end, true)
local minimum = field(gardenPage, "น้ำหนักขั้นต่ำ", "เช่น 20K")
toggle(gardenPage, "เริ่มทำสวน", function(enabled)
	local kg, valid = parseWeight(minimum.Text)
	if enabled and not valid then status.Text = "กรอกน้ำหนักขั้นต่ำ เช่น 20K"; return false end
	local kept = {}
	for egg, checked in pairs(gardenEggs[gardenZone]) do if checked then kept[egg] = true end end
	if enabled and not next(kept) then status.Text = "เลือกไข่สำหรับทำสวนอย่างน้อยหนึ่งชนิด"; return false end
	emit("สวน", enabled, {zone = gardenZone, eggs = kept, minimumWeightKg = kg, tweenSpeed = tweenSpeed})
end)
toggle(fpsPage, "ปิดเอฟเฟกต์ไข่ฟัก", function(enabled) emit("เอฟเฟกต์ไข่ฟัก", enabled, {}) end)

for _, child in ipairs(playerGui:GetChildren()) do
	if child:IsA("ScreenGui") and child:GetAttribute("MyHubStandalonePreview") then
		child:Destroy()
	end
end
gui.Parent = playerGui
local function fit()
	local size = gui.AbsoluteSize
	if size.X > 0 and size.Y > 0 then
		scale.Scale = math.min(1, (size.X - 18) / 560, (size.Y - 18) / 420)
	end
end
gui:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit)
fit()
selectPage(1)
