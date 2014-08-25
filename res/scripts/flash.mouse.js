var FlashMouseController = {
	
	FlashID: "gameSwf",
	ContainerID: "swfDiv",
	
	init: function () {
		if (window.addEventListener) {
			document.oncontextmenu = this.killEvents;
			window.addEventListener("mousedown", this.onOtherMouse, true);
		} else {
			document.oncontextmenu = function () {
				if (window.event.srcElement.id == FlashMouseController.FlashID) {
					return false;
				}
			};
			document.getElementById(this.ContainerID).onmouseup = function () {
				document.getElementById(FlashMouseController.ContainerID).releaseCapture();
			};
			document.getElementById(this.ContainerID).onmousedown = this.onIEMouse;
		}
	},
	
	disableWheel: function (e) {
		var evt = e;
		if (evt == null || typeof (evt) == "undefined") {
		    evt = event;
		}
		
		var delta = (evt.wheelDelta) ? evt.wheelDelta/40 : -evt.detail;
		if (window.addEventListener) {
			if(evt.preventDefault) {
				evt.preventDefault();
			}
		}
		
		FlashMouseController.callback(delta);
	},
	
	mouseWheel: function (enable) {
		if (enable){
			if ( window ) {
				window.removeEventListener('DOMMouseScroll', FlashMouseController.disableWheel, false);
				window.onmousewheel = function(){return true};
			} else {
				document.onmousewheel = function(){return true};
			}
		} else {
			if ( window ) {
				window.addEventListener('DOMMouseScroll', FlashMouseController.disableWheel, false);
				window.onmousewheel =  FlashMouseController.disableWheel;
			} else {
				document.onmousewheel = FlashMouseController.disableWheel;
			}
		}
	},
	
	killEvents: function (e) {
		var evt = e;
		if (evt == null || typeof (evt) == "undefined") {
		    evt = event;
		}
		var target = evt.srcElement ? evt.srcElement : evt.target;
		if (target.id == FlashMouseController.FlashID) {
			if (evt.stopPropagation) evt.stopPropagation();
			if (evt.preventDefault)  evt.preventDefault();
			if (evt.preventCapture)  evt.preventCapture();
			if (evt.preventBubble)   evt.preventBubble();
		}
	},
	
	onOtherMouse: function (e) {
		if (e.button != 0) {
			FlashMouseController.killEvents(e);
			if (e.target.id == FlashMouseController.FlashID) {
				FlashMouseController.callback();
			}
		}
	},
	
	onIEMouse: function (e) {
		if (event.button > 1) {
			if (window.event.srcElement.id == FlashMouseController.FlashID) {
				FlashMouseController.callback();
			}
			document.getElementById(FlashMouseController.ContainerID).setCapture();
		}
	},
	
	callback: function (evt) {
		if (evt == null || typeof (evt) == "undefined") {
			if(document.getElementById(this.FlashID).onFlashRightClick) {
				document.getElementById(this.FlashID).onFlashRightClick();
			}
		}else{
			if(document.getElementById(this.FlashID).onFlashMouseWheel) {
				document.getElementById(this.FlashID).onFlashMouseWheel(evt);
			}
		}
	}
	
}