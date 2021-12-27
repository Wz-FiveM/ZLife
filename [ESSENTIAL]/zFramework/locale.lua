Locales = {}

function _(str, ...)  -- Traduzir string

	if Locales[Config.Locale] ~= nil then

		if Locales[Config.Locale][str] ~= nil then
			return string.format(Locales[Config.Locale][str], ...)
		else
			return 'Tradução [' .. Config.Locale .. '][' .. str .. '] não existe'
		end

	else
		return 'Locale [' .. Config.Locale .. '] não existe'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end
