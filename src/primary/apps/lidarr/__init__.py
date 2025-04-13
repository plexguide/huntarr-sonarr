"""
Lidarr app module for Huntarr
Contains functionality for missing albums and quality upgrades in Lidarr
"""

# Module exports
from primary.apps.lidarr.missing import process_missing_albums
from primary.apps.lidarr.upgrade import process_cutoff_upgrades