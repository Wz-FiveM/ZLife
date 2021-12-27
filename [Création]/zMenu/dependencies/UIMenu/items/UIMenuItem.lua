UIMenuItem = setmetatable({}, UIMenuItem)

UIMenuItem.__index = UIMenuItem

UIMenuItem.__call = function()
    return "UIMenuItem", "UIMenuItem"
end

function UIMenuItem.New(Text, Description)
    local _UIMenuItem = {
        Rectangle = UIResRectangle.New(0, 0, 431, 33, 255, 255, 255, 20),
        Text = UIResText.New(tostring(Text) or "", 8, 0, 0.28, 245, 245, 245, 255, 0),
        _Text = {
            Padding = { X = 8, },
            Colour = {
                Selected = { R = 0, G = 0, B = 0, A = 255 },
                Hovered = { R = 245, G = 245, B = 245, A = 255 },
            }
        },
        _Description = tostring(Description) or "";
        SelectedSprite = Sprite.New("commonmenu", "gradient_nav", 0, 0, 431, 33),
        LeftBadge = { Sprite = Sprite.New("commonmenu", "", 0, 0, 40, 40), Badge = 0},
        RightBadge = { Sprite = Sprite.New("commonmenu", "", 0, 0, 40, 40), Badge = 0},
        Label = {
            Text = UIResText.New("", 0, 0, 0.28, 245, 245, 245, 255, 0, "Right"),
            MainColour = {R = 255, G = 255, B = 255, A = 255},
            HighlightColour = {R = 0, G = 0, B = 0, A = 255},
        },
        _Selected = false,
        _Hovered = false,
        _Enabled = true,
        _Offset = { X = 0, Y = 0 },
        ParentMenu = nil,
        Panels = {},
        Activated = function(menu, item)
        end,
        ActivatedPanel = function(menu, item, panel, panelvalue)
        end,
    }
    return setmetatable(_UIMenuItem, UIMenuItem)
end

function UIMenuItem:SetParentMenu(Menu)
    if Menu ~= nil and Menu() == "UIMenu" then
        self.ParentMenu = Menu
    else
        return self.ParentMenu
    end
end

function UIMenuItem:Selected(bool)
    if bool ~= nil then
        self._Selected = tobool(bool)
    else
        return self._Selected
    end
end

function UIMenuItem:Hovered(bool)
    if bool ~= nil then
        self._Hovered = tobool(bool)
    else
        return self._Hovered
    end
end

function UIMenuItem:Enabled(bool)
    if bool ~= nil then
        self._Enabled = tobool(bool)
    else
        return self._Enabled
    end
end

function UIMenuItem:Description(str)
    if tostring(str) and str ~= nil then
        self._Description = tostring(str)
    else
        return self._Description
    end
end

function UIMenuItem:Offset(X, Y)
    if tonumber(X) or tonumber(Y) then
        if tonumber(X) then
            self._Offset.X = tonumber(X)
        end
        if tonumber(Y) then
            self._Offset.Y = tonumber(Y)
        end
    else
        return self._Offset
    end
end

function UIMenuItem:Position(Y)
    if tonumber(Y) then
        self.Rectangle:Position(self._Offset.X, Y + 144 + self._Offset.Y)
        self.SelectedSprite:Position(0 + self._Offset.X, Y + 144 + self._Offset.Y)
        self.Text:Position(8 + self._Offset.X, Y + 147 + self._Offset.Y)
        self.LeftBadge.Sprite:Position(0 + self._Offset.X, Y + 142 + self._Offset.Y)
        self.RightBadge.Sprite:Position(385 + self._Offset.X, Y + 142 + self._Offset.Y)
        self.Label.Text:Position(420 + self._Offset.X, Y + 148 + self._Offset.Y)
    end
end

function UIMenuItem:RightLabel(Text, MainColour, HighlightColour)
    if MainColour ~= nil then
        labelMainColour = MainColour
    else
        labelMainColour = { R = 255, G = 255, B = 255, A = 255 }
    end
    if HighlightColour ~= nil then
        labelHighlightColour = HighlightColour
    else
        labelHighlightColour = { R = 0, G = 0, B = 0, A = 255 }
    end
    if tostring(Text) and Text ~= nil then
        if type(labelMainColour) == "table" then
            self.Label.MainColour = labelMainColour
        end
        if type(labelHighlightColour) == "table" then
            self.Label.HighlightColour = labelHighlightColour
        end
        self.Label.Text:Text(tostring(Text))
    else
        self.Label.MainColour = { R = 0, G = 0, B = 0, A = 0 }
        self.Label.HighlightColour = { R = 0, G = 0, B = 0, A = 0 }
        return self.Label.Text:Text()
    end
end

function UIMenuItem:SetLeftBadge(Badge)
    if tonumber(Badge) then
        self.LeftBadge.Badge = tonumber(Badge)
    end
end

function UIMenuItem:SetRightBadge(Badge)
    if tonumber(Badge) then
        self.RightBadge.Badge = tonumber(Badge)
    end
end

function UIMenuItem:Text(Text)
    if tostring(Text) and Text ~= nil then
        self.Text:Text(tostring(Text))
    else
        return self.Text:Text()
    end
end

function UIMenuItem:SetTextSelectedColor(R, G, B, A)
    if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
        self._Text.Colour.Selected.R = R
        self._Text.Colour.Selected.G = G
        self._Text.Colour.Selected.B = B
        self._Text.Colour.Selected.A = A
    else
        return { R = self._Text.Colour.Selected.R, G = self._Text.Colour.Selected.G, B = self._Text.Colour.Selected.B, A = self._Text.Colour.Selected.A, }
    end
end

function UIMenuItem:SetTextHoveredColor(R, G, B, A)
    if tonumber(R) and tonumber(G) and tonumber(B) and tonumber(A) then
        self._Text.Colour.Hovered.R = R
        self._Text.Colour.Hovered.G = G
        self._Text.Colour.Hovered.B = B
        self._Text.Colour.Hovered.A = A
    else
        return { R = self._Text.Colour.Hovered.R, G = self._Text.Colour.Hovered.G, B = self._Text.Colour.Hovered.B, A = self._Text.Colour.Hovered.A, }
    end
end

function UIMenuItem:AddPanel(Panel)
    if Panel() == "UIMenuPanel" then
        table.insert(self.Panels, Panel)
        Panel:SetParentItem(self)
    end
end

function UIMenuItem:RemovePanelAt(Index)
    if tonumber(Index) then
        if self.Panels[Index] then
            table.remove(self.Panels, tonumber(Index))
        end
    end
end

function UIMenuItem:FindPanelIndex(Panel)
    if Panel() == "UIMenuPanel" then
        for Index = 1, #self.Panels do
            if self.Panels[Index] == Panel then
                return Index
            end
        end
    end
    return nil
end

function UIMenuItem:FindPanelItem()
    for Index = #self.Items, 1, -1 do
        if self.Items[Index].Panel then
            return Index
        end
    end
    return nil
end

function UIMenuItem:Draw()
    self.Rectangle:Size(431 + self.ParentMenu.WidthOffset, self.Rectangle.Height)
    self.SelectedSprite:Size(431 + self.ParentMenu.WidthOffset, self.SelectedSprite.Height)

    if self._Hovered and not self._Selected then
        self.Rectangle:Draw()
    end

    if self._Selected then
        self.SelectedSprite:Draw()
    end

    if self._Enabled then
        if self._Selected then
            self.Text:Colour(0, 0, 0, 255)
            self.Label.Text:Colour(self.Label.HighlightColour.R, self.Label.HighlightColour.G, self.Label.HighlightColour.B, self.Label.HighlightColour.A)
        else
            self.Text:Colour(245, 245, 245, 255)
            self.Label.Text:Colour(self.Label.MainColour.R, self.Label.MainColour.G, self.Label.MainColour.B, self.Label.MainColour.A)
        end
    else
        self.Text:Colour(163, 159, 148, 255)
        self.Label.Text:Colour(163, 159, 148, 255)
    end

    if self.LeftBadge.Badge == BadgeStyle.None then
        self.Text:Position(8 + self._Offset.X, self.Text.Y)
    else
        self.Text:Position(35 + self._Offset.X, self.Text.Y)
        self.LeftBadge.Sprite.TxtDictionary = GetBadgeDictionary(self.LeftBadge.Badge, self._Selected)
        self.LeftBadge.Sprite.TxtName = GetBadgeTexture(self.LeftBadge.Badge, self._Selected)
        self.LeftBadge.Sprite:Colour(GetBadgeColour(self.LeftBadge.Badge, self._Selected))
        self.LeftBadge.Sprite:Draw()
    end

    if self.RightBadge.Badge ~= BadgeStyle.None then
        self.RightBadge.Sprite:Position(385 + self._Offset.X + self.ParentMenu.WidthOffset, self.RightBadge.Sprite.Y)
        self.RightBadge.Sprite.TxtDictionary = GetBadgeDictionary(self.RightBadge.Badge, self._Selected)
        self.RightBadge.Sprite.TxtName = GetBadgeTexture(self.RightBadge.Badge, self._Selected)
        self.RightBadge.Sprite:Colour(GetBadgeColour(self.RightBadge.Badge, self._Selected))
        self.RightBadge.Sprite:Draw()
    end

    if self.Label.Text:Text() ~= "" and string.len(self.Label.Text:Text()) > 0 then
        self.Label.Text:Position(420 + self._Offset.X + self.ParentMenu.WidthOffset, self.Label.Text.Y)
        self.Label.Text:Draw()
    end

    self.Text:Draw()
end