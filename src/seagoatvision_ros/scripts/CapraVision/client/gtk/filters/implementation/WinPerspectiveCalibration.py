#! /usr/bin/env python

#    Copyright (C) 2012  Club Capra - capra.etsmtl.ca
#
#    This file is part of CapraVision.
#    
#    CapraVision is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

import copy

from gi.repository import Gtk

from CapraVision.client.gtk import get_ui
from CapraVision.client.gtk import win_name

class WinPerspectiveCalibration:
    
    def __init__(self, filtre, cb):
        self.filtre = filtre
        self.filtre_init = copy.copy(filtre)
        self.cb = cb
        
        ui = get_ui(self)
        self.window = ui.get_object(win_name(self))
        self.spnTopLeftX = ui.get_object('spnTopLeftX')
        self.spnTopLeftY = ui.get_object('spnTopLeftY')
        self.spnBottomLeftX = ui.get_object('spnBottomLeftX')
        self.spnBottomLeftY = ui.get_object('spnBottomLeftY')
        self.spnTopRightX = ui.get_object('spnTopRightX')
        self.spnTopRightY = ui.get_object('spnTopRightY')
        self.spnBottomRightX = ui.get_object('spnBottomRightX')
        self.spnBottomRightY = ui.get_object('spnBottomRightY')
        self.spnTranslationX = ui.get_object('spnTranslationX')
        self.spnTranslationY = ui.get_object('spnTranslationY')
        self.spnZoom = ui.get_object('spnZoom')
        self.init_window()

    def init_window(self):
        self.spnTopLeftX.set_adjustment(self.create_adj())
        self.spnTopLeftX.set_value(self.filtre.topLeftX.get_current_value())
        self.spnTopLeftY.set_adjustment(self.create_adj())
        self.spnTopLeftY.set_value(self.filtre.topLeftY.get_current_value())
        self.spnBottomLeftX.set_adjustment(self.create_adj())
        self.spnBottomLeftX.set_value(self.filtre.bottomLeftX.get_current_value())
        self.spnBottomLeftY.set_adjustment(self.create_adj())
        self.spnBottomLeftY.set_value(self.filtre.bottomLeftY.get_current_value())
        self.spnTopRightX.set_adjustment(self.create_adj())
        self.spnTopRightX.set_value(self.filtre.topRightX.get_current_value())
        self.spnTopRightY.set_adjustment(self.create_adj())
        self.spnTopRightY.set_value(self.filtre.topRightY.get_current_value())
        self.spnBottomRightX.set_adjustment(self.create_adj())
        self.spnBottomRightX.set_value(self.filtre.bottomRightX.get_current_value())
        self.spnBottomRightY.set_adjustment(self.create_adj())
        self.spnBottomRightY.set_value(self.filtre.bottomRightY.get_current_value())
        self.spnTranslationX.set_adjustment(self.create_adj())
        self.spnTranslationX.set_value(self.filtre.translationX.get_current_value())
        self.spnTranslationY.set_adjustment(self.create_adj())
        self.spnTranslationY.set_value(self.filtre.translationY.get_current_value())
        self.spnZoom.set_adjustment(self.create_adj())
        self.spnZoom.set_value(self.filtre.zoom.get_current_value())

    def create_adj(self):
        return Gtk.Adjustment(0.0, -65535.0, 65535.0, 1, 10.0, 0.0)
    
    def on_btnOK_clicked(self, widget):
        self.cb()
        self.window.destroy()
        
    def on_btnCancel_clicked(self, widget):
        self.filtre.topLeftX = self.filtre_init.topLeftX
        self.filtre.topLeftY = self.filtre_init.topLeftY
        self.filtre.bottomLeftX = self.filtre_init.bottomLeftX
        self.filtre.bottomLeftY = self.filtre_init.bottomLeftY
        self.filtre.topRightX = self.filtre_init.topRightX
        self.filtre.topRightY = self.filtre_init.topRightY
        self.filtre.bottomRightX = self.filtre_init.bottomRightX
        self.filtre.bottomRightY = self.filtre_init.bottomRightY
        self.filtre.translationX = self.filtre_init.translationX
        self.filtre.translationY = self.filtre_init.translationY
        self.filtre.zoom = self.filtre_init.zoom
        self.init_window()
        
    def on_spnTopLeftX_value_changed(self, widget):
        self.filtre.topLeftX.set_current_value(self.spnTopLeftX.get_value())
        self.filtre.configure()
        
    def on_spnTopLeftY_value_changed(self, widget):
        self.filtre.topLeftY.set_current_value(self.spnTopLeftY.get_value())
        self.filtre.configure()

    def on_spnBottomLeftX_value_changed(self, widget):
        self.filtre.bottomLeftX.set_current_value(self.spnBottomLeftX.get_value())
        self.filtre.configure()
        
    def on_spnBottomLeftY_value_changed(self, widget):
        self.filtre.bottomLeftY.set_current_value(self.spnBottomLeftY.get_value())
        self.filtre.configure()
        
    def on_spnTopRightX_value_changed(self, widget):
        self.filtre.topRightX.set_current_value(self.spnTopRightX.get_value())
        self.filtre.configure()

    def on_spnTopRightY_value_changed(self, widget):
        self.filtre.topRightY.set_current_value(self.spnTopRightY.get_value())
        self.filtre.configure()
        
    def on_spnBottomRightX_value_changed(self, widget):
        self.filtre.bottomRightX.set_current_value(self.spnBottomRightX.get_value())
        self.filtre.configure()

    def on_spnBottomRightY_value_changed(self, widget):
        self.filtre.bottomRightY.set_current_value(self.spnBottomRightY.get_value())
        self.filtre.configure()

    def on_spnZoom_value_changed(self, widget):
        self.filtre.zoom.set_current_value(self.spnZoom.get_value())
        self.filtre.configure()

    def on_spnTranslationX_value_changed(self, widget):
        self.filtre.translationX.set_current_value(self.spnTranslationX.get_value())
        self.filtre.configure()

    def on_spnTranslationY_value_changed(self, widget):
        self.filtre.translationY.set_current_value(self.spnTranslationY.get_value())
        self.filtre.configure()