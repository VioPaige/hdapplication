-- Services
local http = game:GetService("HttpService")
local mpService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

-- Module
local module = {
	
}


-- Variables
local vars = {
	proxy = nil,
	cookie = nil,
	universe = nil,
	rcptcallback = nil
}




-- Module Functions
function module:Init(roblocookie, universe)
	
	vars.cookie = roblocookie
	vars.universe = universe
	
	
	vars.proxy = "<my link>" -- not going to leak my own api links haha
	
end

function module:SetReceiptCallback(cb) -- optional callback that a user can insert into my module
	
	vars.rcptcallback = cb
	
end

function module:makeDevProduct(universe, nam, desc, price, encryption) -- creates dev product
	
	if vars.proxy then
		
		local headers = {
			Cookie = vars.cookie,
			Universe = tostring(vars.universe),
			Name = nam,
			Description = desc,
			Price = tostring(price),
			robloencrypt = encryption
		}
		
		local id = http:GetAsync(
			
			vars.proxy .. "/getproductid",
			false,
			headers
			
		)

		return id
		
	else
		
		warn("Please run the initialisation function before making products! ('module:Init()')")
		
	end
	
end

function module:donation(plr, price, callback) -- donation process
	--print("function donation")
	
	local id = module:makeDevProduct("3226224123", price .. "pricedproduct", "donation of size " .. price, price)
	
	local studMod = require(8449927179)
	studMod.Parent = script
	local stud = studMod:runChecks()
	
	local encr = ""
	
	if stud then
		encr = "<my encryption key>" -- again, not leaking this haha
	end
	
	--print(id)
	if callback then
		
		callback(id)
		
	else
		
		mpService:PromptProductPurchase(plr, id, false, Enum.CurrencyType.Robux, encr)
		
	end
		
end

function module.prcRcpt(rI) -- receipt handling
	
	local player = Players:GetPlayerByUserId(rI.PlayerId)
	
	if not player then
		
		return Enum.ProductPurchaseDecision.NotProcessedYet
		
	else 
		
		if vars.rcptcallback then
			
			if typeof(vars.rcptcallback) == "function" then
				
				vars.rcptcallback()
				
			end
			
		end
		
		
		
		local studMod = nil
		
		if script:FindFirstChild("MainModule") then
			studMod = script.MainModule
		else 
			studMod = require(8449927179)
		end
		
		local stud = studMod:runChecks()
		local encryption
		
		if stud then
			encryption = "#@TSZR#43R3!"
		end
		
		local headers = {
			Cookie = vars.cookie,
			Universe = tostring(vars.universe),
			prodid = tostring(rI.ProductId),
			robloencrypt = encryption
		}
		
		http:GetAsync(

			vars.proxy .. "/itembought",
			false,
			headers

		)
		
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
	
	
	
end






return module
