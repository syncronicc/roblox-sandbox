local RunService=game:GetService('RunService')

local wall=Instance.new('Folder')
wall.Name='Wall'
wall.Parent=workspace

local length=35
local height=35

local base_location=workspace:WaitForChild('location')
for x=0,length do
	for y=0,height do
		local part=Instance.new('Part')
		part.Size=Vector3.new(1,1,1)
		part.Position=Vector3.new(x+base_location.Position.X,y+base_location.Position.Y,base_location.Position.Z)
		part.Parent=wall
		part.Color=Color3.fromRGB(x,y,0)
		part.Anchored=true
		part.CanCollide=false
	end
end

RunService.RenderStepped:Connect(function()
	for _,part:BasePart in wall:GetChildren()do
		local origin=part.Position
		local direction=Vector3.new(0,0,-50)
		local params=RaycastParams.new()
		
		params.FilterType=Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances={part}
		
		local result=workspace:Raycast(origin,direction,params)
		if result and result.Instance:IsA('BasePart')then
			part.Color=result.Instance.Color
			part.Material=result.Instance.Material
			part.Transparency=0
		else
			part.Color=Color3.fromRGB(origin.X,origin.Y,0)
			part.Material=Enum.Material.Air
			part.Transparency=1
		end
	end
end)
