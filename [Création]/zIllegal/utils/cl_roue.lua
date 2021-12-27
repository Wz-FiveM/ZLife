local currentMenu
local Dialogue = {}

function Dialogue:CreateCam(Ped)
	selfBaseCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
	SetCamActive(selfBaseCam, true)
	--AttachCamToEntity(self.Base.Cam, Ped, 0.0, -0.75, 0.6, true)
	AttachCamToEntity(selfBaseCam, Ped, 0.0, 0.75, 0.6, true)
	SetCamRot(selfBaseCam, 0.0, 0.0, GetEntityHeading(Ped) - 180.0, 2)
    RenderScriptCams(1, 1, 750, 1, 0)
end

function Dialogue:DestroyCam()
	DestroyCam(selfBaseCam)
	RenderScriptCams(0, 1, 1000, 0, 0)
end

--local currentFocus
AddEventHandler("clp:toggleroue", function(menuData, cam, ped)
	if currentFocus then currentFocus = false Citizen.Wait(0) end
	SetNuiFocus(true, true)
	SetKeepInputMode(true)
	currentMenu = menuData

	SendNUIMessage({ menu = currentMenu.menu, params = currentMenu.params })
    currentFocus = true
    
    if cam and ped then 
        Dialogue:CreateCam(ped)
    end
    while selfBaseCam do 
        Wait(0)
        if selfBaseCam then
            SetLocalPlayerInvisibleLocally(PlayerId())
        end
    end
end)

local function onClose()
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
    if selfBaseCam then
        selfBaseCam = nil
		Dialogue:DestroyCam()
	end
	if currentMenu and currentMenu.onExited then currentMenu.onExited() end
	currentMenu = {}
	SetNuiFocus()
	SetKeepInputMode(false)
	currentFocus = false
end

RegisterNUICallback("menuOnSelected", function(t, cb)
	local menuData = currentMenu
	if not t or not t[1] or not menuData or not menuData.onSelected then 
		onClose() 
		return 
	end

	local menuID, slt = table.unpack(t[1])
	Citizen.CreateThread(function() 
		menuData.onSelected(menuID, slt, menuData and menuData.menu and menuData.menu[menuID][slt]) 
	end)
	if t[2] then 
        onClose() 
	end
end)

RegisterNUICallback("menuKeyPress", function(t, cb)
	cb("ok")
end)
--[[ local tes1={
    onSelected=dx,
    params={close=true},
    menu={
        {
            {name="Allergies",icon="fas fa-allergies"},
            {name="Cinematique",icon="fas fa-film"},
            {name="Camion ambulance",icon="fas fa-ambulance"},
            {name="Avocat",icon="fab fa-adn"},
            {name="Jour/Nuit",icon="fas fa-adjust"},

            {name="Handicap Roulant Fauteuil",icon="fab fa-accessible-icon"},
            {name="Tente",icon="fab fa-accusoft"},
            {name="Livret",icon="fa fa-address-book"},
            {name="Identite",icon="fa fa-address-card"},
            {name="Test5",icon="fab fa-adversal"},
		{
			{name="Animations",icon="fas fa-child",cb=1},
			{name="Actions",icon="fas fa-location-arrow",cb=2},
			{name="Civière",icon="fas fa-dolly-flatbed",cb=4},
		},
		{
			{name="Arrêter",icon="far fa-stop-circle"},
			{name="Ausculter",icon="fas fa-file-medical-alt",id="CODE_HUMAN_MEDIC_KNEEL"},
			{name="Massage cardiaque",icon="fas fa-heartbeat",id="CODE_HUMAN_MEDIC_TEND_TO_DEAD"},
			{name="Prendre des notes",icon="fas fa-user-md",id="CODE_HUMAN_MEDIC_TIME_OF_DEATH"},
			{name="Prendre des photos",icon="fas fa-camera",id="WORLD_HUMAN_PAPARAZZI"}
		},
		{
			{name="Réanimation",icon="fas fa-heartbeat"},
			{name="Soigner",icon="fas fa-medkit"},
			{name="Constater blessures",icon="fas fa-file-medical-alt"}
		},
		{
			{name="Ramasser",icon="fas fa-undo"},
			{name="Barrière",icon="fas fa-bars",h="prop_barrier_work06a"},
			{name="Plot",icon="fas fa-exclamation-triangle",h="prop_byard_net02"}
		},
		{
			{name="Placer",icon="fas fa-dolly-flatbed"},
			{name="Sortir",icon="fas fa-sign-out-alt"},
			{name="Ranger",icon="far fa-minus-square"}
		}
            {name="Corne",icon="fab fa-affiliatetheme"},
            {name="Chrono",icon="fab fa-algolia"},
            {name="Barre",icon="fa fa-align-center"},
            {name="Barre",icon="fa fa-align-justify"},
            {name="Barre",icon="fa fa-align-right"},

            {name="Amazon",icon="fab fa-amazon"},
            {name="Amilia",icon="fab fa-amilia"},
            {name="Android",icon="fab fa-android"},
            {name="Peace",icon="fab fa-angellist"},
            {name="Vers le bas",icon="fa fa-angle-double-down"},

            {name="Enervé",icon="fa fa-angry"},
            {name="Enervé",icon="fab fa-angrycreative"},
            {name="Apple",icon="fab fa-app-store"},
            {name="Apper",icon="fab fa-apper"},
            {name="Boîte",icon="fa fa-archive"},

            {name="Arche",icon="fa fa-archway"},
            {name="Vers le bas",icon="fa fa-arrow-alt-circle-down"},
            {name="Oreille",icon="fa fa-assistive-listening-systems"},
            {name="Asterix",icon="fa fa-asterisk"},
            {name="Avocat",icon="fab fa-asymmetrik"},

            {name="Arobase",icon="fa fa-at"},
            {name="Livre atlas",icon="fa fa-atlas"},
            {name="Livre ouvert",icon="fab fa-audible"},
            {name="Test4",icon="fa fa-audio-description"},
            {name="Avocat",icon="fab fa-autoprefixer"},

            {name="Avion",icon="fab fa-avianex"},
            {name="Symbole avion",icon="fab fa-aviato"},
            {name="Médaille",icon="fa fa-award"},
            {name="AWS",icon="fab fa-aws"},
            {name="BackSpace",icon="fa fa-backspace"},

            {name="Retour",icon="fa fa-backward"},
            {name="Test2",icon="fab fa-bandcamp"},
            {name="CodeBar",icon="fa fa-barcode"},
            {name="Balance",icon="fa fa-balance-scale"},
            {name="Sens interdit",icon="fa fa-ban"},

            {name="Barres alignées",icon="fa fa-bars"},
            {name="Baignoire",icon="fa fa-bath"},
            {name="Lit",icon="fa fa-bed"},
            {name="Bière",icon="fa fa-beer"},
            {name="Test5",icon="fab fa-behance"},

            {name="Petit bitcoin",icon="fab fa-bity"},
            {name="Vélo",icon="fa fa-bicycle"},
            {name="Test3",icon="fab fa-bimobject"},
            {name="Jumelles",icon="fa fa-binoculars"},
            {name="Seau",icon="fab fa-bitbucket"},

            {name="Taches",icon="fab fa-blackberry"},
            {name="Mixer",icon="fa fa-blender"},
            {name="Vieux canne",icon="fa fa-blind"},
            {name="Test4",icon="fab fa-blogger"},
            {name="Bluetooth",icon="fab fa-bluetooth"},

            {name="B",icon="fa fa-bold"},
            {name="Bombe",icon="fa fa-bomb"},
            {name="Bong",icon="fa fa-bong"},
            {name="Livre",icon="fa fa-book"},
            {name="Badge livre",icon="fa fa-bookmark"},

            {name="Boîte",icon="fa fa-box"},
            {name="Taches",icon="fa fa-braille"},
            {name="Malette",icon="fa fa-briefcase"},
            {name="Malette ambulance",icon="fa fa-briefcase-medical"},
            {name="Pinceau",icon="fa fa-broom"},

            {name="Pinceau",icon="fa fa-brush"},
            {name="BitCoin",icon="fab fa-btc"},
            {name="Puces",icon="fa fa-bug"},
            {name="Batiment",icon="fa fa-building"},
            {name="Mégaphone",icon="fa fa-bullhorn"},

            {name="Cible",icon="fa fa-bullseye"},
            {name="Goute / Essence",icon="fa fa-burn"},
            {name="Cubes",icon="fab fa-buromobelexperte"},
            {name="Bus",icon="fa fa-bus"},
            {name="Mégaphone",icon="fab fa-buysellads"},

            {name="Carculatrice",icon="fa fa-calculator"},
            {name="Calendrier",icon="fa fa-calendar"},
            {name="Photo",icon="fa fa-camera"},
            {name="Cannabis",icon="fa fa-cannabis"},
            {name="Pillule",icon="fa fa-capsules"},

            {name="Voiture",icon="fa fa-car"},
            {name="Cadis",icon="fa fa-cart-plus"},
            {name="Photo",icon="fab fa-centercode"},
            {name="Asterix",icon="fa fa-certificate"},
            {name="Ordinateur",icon="fa fa-chalkboard"},

            {name="Statistique",icon="fa fa-chart-area"},
            {name="Valider",icon="fa fa-check"},
            {name="Echeque",icon="fa fa-chess"},
            {name="Valider",icon="fa fa-chevron-circle-down"},
            {name="Lever les mains",icon="fa fa-child"},

            {name="Chrome",icon="fab fa-chrome"},
            {name="Eglise",icon="fa fa-church"},
            {name="Point",icon="fa fa-circle"},
            {name="Notes",icon="fa fa-clipboard"},
            {name="Horloge",icon="fa fa-clock"},

            {name="Double cube",icon="fa fa-clone"},
            {name="Nuages",icon="fa fa-cloud"},
            {name="Coktail",icon="fa fa-cocktail"},
            {name="Div",icon="fa fa-code"},
            {name="Cube 3d",icon="fab fa-codepen"},

            {name="PacMan",icon="fab fa-codiepie"},
            {name="Café",icon="fa fa-coffee"},
            {name="Roue Parametres",icon="fa fa-cog"},
            {name="Pieces",icon="fa fa-coins"},
            {name="Fenetre",icon="fa fa-columns"},

            {name="Message",icon="fa fa-comment"},
            {name="Disques Disc",icon="fa fa-compact-disc"},
            {name="Boussole",icon="fa fa-compass"},
            {name="Ecran",icon="fa fa-compress"},
            {name="Sonettes Sonnettes Sonnerie",icon="fa fa-concierge-bell"},

            {name="Carte bleu bancaire",icon="fa fa-credit-card"},
            {name="Canape Bancete Banquete",icon="fa fa-couch"},
            {name="Cookie",icon="fa fa-cookie"},
            {name="Copier Coller",icon="fa fa-copy"},
            {name="Ecran",icon="fa fa-crop-alt"},

            {name="Cross Air",icon="fa fa-crosshairs"},
            {name="Oiseau",icon="fa fa-crow"},
            {name="Courrone",icon="fa fa-crown"},
            {name="Boîte Cube",icon="fa fa-cubes"},
            {name="Boîte Cube",icon="fa fa-cube"},

            {name="Oreille",icon="fa fa-deaf"},
            {name="Ciseau",icon="fa fa-cut"},
            {name="Elephant",icon="fab fa-deskpro"},
            {name="Echeque",icon="fab fa-delicious"},
            {name="Pieces",icon="fa fa-database"},

            {name="Ordinateur Ecran",icon="fa fa-desktop"},
            {name="Message",icon="fab fa-discourse"},
            {name="Table Homme Cirque",icon="fa fa-diagnoses"},
            {name="Discord",icon="fab fa-discord"},
            {name="Domino",icon="fa fa-dice"},

            {name="Division",icon="fa fa-divide"},
            {name="Smiley mort",icon="fa fa-dizzy"},
            {name="Sablier Dna",icon="fa fa-dna"},
            {name="Argent Dollars",icon="fa fa-dollar-sign"},
            {name="Ballene Balene",icon="fab fa-docker"},

            {name="Colis",icon="fa fa-dolly"},
            {name="Compas",icon="fa fa-drafting-compass"},
            {name="Rond Disc",icon="fa fa-dot-circle"},
            {name="Oiseau",icon="fa fa-dove"},
            {name="Dl DownLoad Telecharger",icon="fa fa-download"},

            {name="Trois petit points",icon="fa fa-ellipsis-h"},
            {name="Hibou",icon="fab fa-earlybirds"},
            {name="Fleches vers le haut",icon="fa fa-eject"},
            {name="Message Envelope",icon="fa fa-envelope"},
            {name="Edit Modifier",icon="fa fa-edit"},
        }
    }
} ]]