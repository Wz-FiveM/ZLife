NativeUI = {}

function NativeUI.CreatePool()
    return MenuPool.New()
end

function NativeUI.CreateMenu(Title, Subtitle, X, Y, TxtDictionary, TxtName, Heading, R, G, B, A)
    return UIMenu.New(Title, Subtitle, X, Y, TxtDictionary, TxtName, Heading, R, G, B, A)
end

function NativeUI.CreateItem(Text, Description)
    return UIMenuItem.New(Text, Description)
end

function NativeUI.CreateColouredItem(Text, Description, MainColour, HighlightColour)
    return UIMenuColouredItem.New(Text, Description, MainColour, HighlightColour)
end

function NativeUI.CreateCheckboxItem(Text, Check, Description, CheckboxStyle)
    return UIMenuCheckboxItem.New(Text, Check, Description, CheckboxStyle)
end

function NativeUI.CreateListItem(Text, Items, Index, Description)
    return UIMenuListItem.New(Text, Items, Index, Description)
end

function NativeUI.CreateSliderItem(Text, Items, Index, Description, Divider, SliderColors, BackgroundSliderColors)
    return UIMenuSliderItem.New(Text, Items, Index, Description, Divider, SliderColors, BackgroundSliderColors)
end

function NativeUI.CreateSliderHeritageItem(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
    return UIMenuSliderHeritageItem.New(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
end

function NativeUI.CreateSliderProgressItem(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
    return UIMenuSliderProgressItem.New(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
end

function NativeUI.CreateProgressItem(Text, Items, Index, Description, Counter)
    return UIMenuProgressItem.New(Text, Items, Index, Description, Counter)
end

function NativeUI.CreateHeritageWindow(Mum, Dad)
    return UIMenuHeritageWindow.New(Mum, Dad)
end

function NativeUI.CreateGridPanel(TopText, LeftText, RightText, BottomText, CirclePositionX, CirclePositionY)
    return UIMenuGridPanel.New(TopText, LeftText, RightText, BottomText, CirclePositionX, CirclePositionY)
end

function NativeUI.CreateHorizontalGridPanel(LeftText, RightText, CirclePositionX)
    return UIMenuHorizontalOneLineGridPanel.New(LeftText, RightText, CirclePositionX)
end

function NativeUI.CreateVerticalGridPanel(TopText, BottomText, CirclePositionY)
    return UIMenuVerticalOneLineGridPanel.New(TopText, BottomText, CirclePositionY)
end

function NativeUI.CreateColourPanel(Title, Colours)
    return UIMenuColourPanel.New(Title, Colours)
end

function NativeUI.CreatePercentagePanel(MinText, MaxText)
    return UIMenuPercentagePanel.New(MinText, MaxText)
end

function NativeUI.CreateStatisticsPanel()
    return UIMenuStatisticsPanel.New()
end

function NativeUI.CreateSprite(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
    return Sprite.New(TxtDictionary, TxtName, X, Y, Width, Height, Heading, R, G, B, A)
end

function NativeUI.CreateRectangle(X, Y, Width, Height, R, G, B, A)
    return UIResRectangle.New(X, Y, Width, Height, R, G, B, A)
end

function NativeUI.CreateText(Text, X, Y, Scale, R, G, B, A, Font, Alignment, DropShadow, Outline, WordWrap)
    return UIResText.New(Text, X, Y, Scale, R, G, B, A, Font, Alignment, DropShadow, Outline, WordWrap)
end

function NativeUI.CreateTimerBarProgress(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
    return UITimerBarProgressItem.New(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
end

function NativeUI.CreateTimerBar(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
    return UITimerBarItem.New(Text, TxtDictionary, TxtName, X, Y, Heading, R, G, B, A)
end

function NativeUI.CreateTimerBarProgressWithIcon(TxtDictionary, TxtName, IconDictionary, IconName, X, Y, Heading, R, G, B, A)
    return UITimerBarProgressWithIconItem.New(TxtDictionary, TxtName, IconDictionary, IconName, X, Y, Heading, R, G, B, A)
end

function NativeUI.TimerBarPool()
    return UITimerBarPool.New()
end

function NativeUI.ProgressBarPool()
    return UIProgressBarPool.New()
end

function NativeUI.CreateProgressBarItem(Text, X, Y, Heading, R, G, B, A)
    return UIProgressBarItem.New(Text, X, Y, Heading, R, G, B, A)
end