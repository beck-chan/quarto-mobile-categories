--[[
  Embeds Quarto's margin listing category filters as an inline dropdown.

  Usage:
    ::: {.mobile-categories}
    :::

  On mobile, the dropdown mirrors .quarto-listing-category options and
  drives window.quartoListingCategory. On desktop the embed is hidden so
  the margin sidebar remains the filter UI.
]]

local deps_injected = false
local select_count = 0

local function is_html()
  return quarto.doc.is_format("html:js") or quarto.doc.is_format("html")
end

local function ensure_deps()
  if deps_injected then
    return
  end
  quarto.doc.add_html_dependency({
    name = "mobile-categories",
    version = "1.0.0",
    stylesheets = { "mobile-categories.css" },
    scripts = { "mobile-categories.js" }
  })
  deps_injected = true
end

function Div(div)
  if not div.classes:includes("mobile-categories") then
    return nil
  end
  if not is_html() then
    return nil
  end

  ensure_deps()
  select_count = select_count + 1

  local extra = {}
  for _, class in ipairs(div.classes) do
    if class ~= "mobile-categories" then
      table.insert(extra, class)
    end
  end

  local classes = { "mobile-categories" }
  for _, class in ipairs(extra) do
    table.insert(classes, class)
  end

  local id_attr = ""
  if div.identifier ~= "" then
    id_attr = ' id="' .. div.identifier:gsub('"', "&quot;") .. '"'
  end

  local select_id = "mobile-categories-select-" .. tostring(select_count)

  local html = table.concat({
    '<div' .. id_attr .. ' class="' .. table.concat(classes, " ") .. '">',
    '  <label class="mobile-categories__label" for="' .. select_id .. '">',
    '    <span class="mobile-categories__label-text">Filter by category</span>',
    "  </label>",
    '  <select id="' .. select_id .. '" class="mobile-categories__select"',
    '    aria-label="Filter by category">',
    '    <option value="">All</option>',
    "  </select>",
    "</div>"
  }, "\n")

  return pandoc.RawBlock("html", html)
end
