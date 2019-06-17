class Inp < ApplicationRecord
  belongs_to :upload

  KNOWN_TYPES = [
    "COMPLIANCE",
    "CONSTRUCTION",
    "GLASS",
    "DHW-GENERATOR",
    "HVAC-SYSTEM",
    "ZONE",
    "WALL",
    "WINDOW",
    "DOOR",
    "REC-USER",
    "GENERAL",
    "REC-PROJECT"
  ]
end
