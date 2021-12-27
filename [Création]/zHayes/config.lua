LsCustoms = LsCustoms or {}
LsCustoms.Pos = {
	{pos = vector3(-319.5214, -123.45800, 39.0169),vector3(474.252, -1882.9552, 26.08733), job = "lscustoms", "atomic", notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~Hayes Auto~s~.", header = {"shopui_title_supermod", "shopui_title_supermod"}, size = 10.0, blips = {
		display = 72,
		colour = 0,
		size = 0.8,
		name = "Ls Custom",
	}},
}

LsCustoms.Items = {
	{name = "moteur", trigger = "zHayes:useMoteur"},
	{name = "pneu", trigger = "zHayes:usePneu"},
	{name = "carosskit", trigger = "zHayes:useCarossKit"},
	{name = "repairkit", trigger = "zHayes:useRepairKit"},
}