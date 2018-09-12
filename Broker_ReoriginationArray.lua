local _G = getfenv(0)

local MODNAME	= "Broker_ReoriginationArray"
local addon = LibStub("AceAddon-3.0"):NewAddon(MODNAME, "AceEvent-3.0")
_G.Broker_ReoriginationArray = addon

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local L = LibStub("AceLocale-3.0"):GetLocale(MODNAME)

local weekly_first = 53568
local weekly_second = 53569
local weekly_third = 53570

local one = 53571
local two = 53572
local three = 53573
local four = 53574
local five = 53575
local six = 53576
local seven = 53577
local eight = 53578
local nine = 53579
local ten = 53580

function addon:OnInitialize()
	self.info = {
		weekly = 0,
		perm = 0,
	}

	self:RegisterEvent("QUEST_COMPLETE", "UpdateInfo")

	self:UpdateInfo()
	self:MainUpdate()
end

function addon:OnEnable()
	self:UpdateInfo()
end

-- LDB object
addon.obj = ldb:NewDataObject(MODNAME, {
	type = "data source",
	label = "Broker_ReoriginationArray",
	text = "",
	icon = "Interface\\Icons\\inv_trinket_80_titan02c",
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine(MODNAME.." "..GetAddOnMetadata(MODNAME, "Version"))

		addon:UpdateInfo()

		tooltip:AddDoubleLine(L["Killed this week"], string.format("%d / 3", addon.info.weekly))
		tooltip:AddDoubleLine(L["Bufflevel"], string.format("%d / 10", addon.info.perm))
	end,
})


-- Main update function
function addon:MainUpdate()
	self.obj.text = (string.format("%d/3 %d/10", self.info.weekly, self.info.perm))
end


function addon:UpdateInfo()
	if IsQuestFlaggedCompleted(weekly_third) then
		self.info.weekly = 3
	elseif IsQuestFlaggedCompleted(weekly_second) then
		self.info.weekly = 2
	elseif IsQuestFlaggedCompleted(weekly_first) then
		self.info.weekly = 1
	end

	if IsQuestFlaggedCompleted(ten) then
		self.info.perm = 10
	elseif IsQuestFlaggedCompleted(nine) then
		self.info.perm = 9
	elseif IsQuestFlaggedCompleted(eight) then
		self.info.perm = 8
	elseif IsQuestFlaggedCompleted(seven) then
		self.info.perm = 7
	elseif IsQuestFlaggedCompleted(six) then
		self.info.perm = 6
	elseif IsQuestFlaggedCompleted(five) then
		self.info.perm = 5
	elseif IsQuestFlaggedCompleted(four) then
		self.info.perm = 4
	elseif IsQuestFlaggedCompleted(three) then
		self.info.perm = 3
	elseif IsQuestFlaggedCompleted(two) then
		self.info.perm = 2
	elseif IsQuestFlaggedCompleted(one) then
		self.info.perm = 1
	end

	self:MainUpdate()
end
