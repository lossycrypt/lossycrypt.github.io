-- --------------------------------------------------------------------------- --
-- config                                                                      --
-- --------------------------------------------------------------------------- --


-- file = '.'
title = 'Erlib Documentation'
description = "Eradicator's Library."
full_description = [[
  This library contains all complex functions i use throughout several of my mods.
  ]]

local root = '..'

-- dir=".\\..\\html"
dir  = root..'/html'
file = root..'/erlib'


--Sort entries within sections alphabetically? (or @set sort=true per module)
sort=false

--Include local functions in the documentation? (can't be set per module?)
all=true


one=true --one column? i see no change
--readme = 'readme.md'


-- --------------------------------------------------------------------------- --
-- shorthands                                                                  --
-- --------------------------------------------------------------------------- --
--[1] https://stevedonovan.github.io/ldoc/manual/doc.md.html#Adding_new_Tags

alias("arg","tparam") -- creates an @arg tag that means the same as @tparam



-- --------------------------------------------------------------------------- --
-- @see handler urls                                                           --
-- --------------------------------------------------------------------------- --
-- Learned by looking at STDLIB's config.
-- [1] https://stevedonovan.github.io/ldoc/
-- [2] https://github.com/Afforess/Factorio-Stdlib/blob/master/doc/config.ld    
-- Quirks: Keywords and string methods are the only usable functions in config.ld!
--         Public functions like next, pairs, print, etc are not available!

local url = {
  --NamedSection
  local_modules = '../modules/%s.html#%s', -- Eradicators Library
  local_api     = '../api/%s.html#%s',     -- Factorio API Documentation
  --FixedPage
  remote_lua    = 'https://www.lua.org/pil/%s.html%s',
  --CustomUrlHandler
  wikipedia     = 'https://en.wikipedia.org/wiki/%s', -- @{wiki <page_name>|Title}
  }
  
-- --------------------------------------------------------------------------- --
-- @see handler factories                                                      --
-- --------------------------------------------------------------------------- --

--custom_see_handler(RegEx,Function)
--LDoc evaluates the RegEx and then
--@tparam string n the first match of the RegEx

local function FixedPage(url) 
  return function (page,section)
    return function(n) return n,url:format(page,section) end
    end
  end

local function NamedSection(url,page)
  return function(n) return n, url:format(page,n) end
  end

local function NamedPage(url)
  return function(n) return n, url:format(n) end
  end

  
-- --------------------------------------------------------------------------- --
-- custom @see handlers                                                        --
-- --------------------------------------------------------------------------- --

-- Wikipedia (English)
local function Wiki(page)
  --remove whitespace
  page = page:gsub(' ','_')
  --automatically remove the disambiguation brackets from the name
  --example: "Set_(mathematics)" -> "Set"
  local name = (page:match('^(.*)(_%(.*%))$')) or page
  return name,url.wikipedia:format(page)
  end
custom_see_handler('^wiki (.+)', Wiki)


-- --------------------------------------------------------------------------- --
-- bulk @see handlers                                                          --
-- --------------------------------------------------------------------------- --

-- Types (Eradicator's Library)
local EradicatorsTypes = NamedSection(url.local_modules,'Types')
custom_see_handler('^(Table)$'         ,EradicatorsTypes)
custom_see_handler('^(Set)$'           ,EradicatorsTypes)
custom_see_handler('^(Array)$'         ,EradicatorsTypes)
custom_see_handler('^(SparseArray)$'   ,EradicatorsTypes)
custom_see_handler('^(Number)$'        ,EradicatorsTypes)
custom_see_handler('^(Float)$'         ,EradicatorsTypes)
custom_see_handler('^(Integer)$'       ,EradicatorsTypes)
custom_see_handler('^(NaturalNumber)$' ,EradicatorsTypes)
custom_see_handler('^(NotNil)$'        ,EradicatorsTypes)
custom_see_handler('^(AnyValue)$'      ,EradicatorsTypes)
custom_see_handler('^(TruthyValue)$'   ,EradicatorsTypes)
custom_see_handler('^(true)$'          ,EradicatorsTypes)
custom_see_handler('^(LoadStageName)$' ,EradicatorsTypes)
custom_see_handler('^(LoadPhaseName)$' ,EradicatorsTypes)
custom_see_handler('^(LoadStageTable)$',EradicatorsTypes)

-- Builtin-Types (Factorio)
local FactorioBuiltinTypes = NamedSection(url.local_api,'Builtin-Types')
custom_see_handler('^(boolean)$'       , FactorioBuiltinTypes)
custom_see_handler('^(int)$'           , FactorioBuiltinTypes)
custom_see_handler('^(uint)$'          , FactorioBuiltinTypes)
custom_see_handler('^(uint8)$'         , FactorioBuiltinTypes)
custom_see_handler('^(uint64)$'        , FactorioBuiltinTypes)
custom_see_handler('^(string)$'        , FactorioBuiltinTypes)
custom_see_handler('^(float)$'         , FactorioBuiltinTypes)
custom_see_handler('^(double)$'        , FactorioBuiltinTypes)

-- Generic Lua Types
local LuaDoc = FixedPage(url.remote_lua) --Thank you Stdlib!
custom_see_handler("^(nil)$"           , LuaDoc("2.1" , ""             ))
custom_see_handler("^(number)$"        , LuaDoc("2.3" , ""             ))
custom_see_handler("^(table)$"         , LuaDoc("2.5" , ""             ))
custom_see_handler("^(function)$"      , LuaDoc("2.6" , ""             ))
custom_see_handler("^(userdata)$"      , LuaDoc("2.7" , ""             ))
custom_see_handler("^(thread)$"        , LuaDoc("9"   , "#CoroutineSec"))
custom_see_handler("^(array)$"         , LuaDoc("11.1", ""             ))
custom_see_handler("^(sort)$"          , LuaDoc("19.3", ""             ))
custom_see_handler("^(pattern)$"       , LuaDoc("20.2", ""             ))
