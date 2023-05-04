const NS = "http://www.w3.org/2000/svg";

/**
* Svg Class
*/
class Svg {
    constructor(w, h) {
        this.width = w;
        this.height = h;

        this.node = document.createElementNS(NS, "svg");

        this.render();
    }

    render() {
        this.node.setAttributeNS(null, "width", this.width);
        this.node.setAttributeNS(null, "height", this.height);
    }

    getNode() {
        return this.node;
    }
}

/**
* Circle Class
*/
class Circle {
    constructor(r, s, min = 0, max = 360, bg = false, zone = false) {
        this.radius = r;
        this.stroke = s;
        this.minAngle = min;
        this.maxAngle = max;
        this.px = this.radius;
        this.py = this.radius;
        this.bg = bg;
        this.zone = zone;
        this.offset = 0;
        this.progress = 0;

        this.node = document.createElementNS(NS, "circle");

        this.render();
    }

    render() {
        this.setArc();

        this.node.setAttributeNS(null, "r", this.radius - (this.stroke / 2));
        this.node.setAttributeNS(null, "cx", this.px);
        this.node.setAttributeNS(null, "cy", this.py);
        this.node.setAttributeNS(null, "stroke-width", this.stroke);
    }

    setArc() {
        this.arc = 2 * Math.PI * (this.radius - (this.stroke / 2));
        this.gap = this.arc - this.arc * ((this.maxAngle - this.minAngle) / 360);

        this.node.setAttributeNS(
            null,
            "stroke-dasharray",
            this.bg ? `${this.arc - this.gap}, ${this.gap}` : this.arc
        );

        this.setProgress();
    }

    getNode() {
        return this.node;
    }

    setProgress(progress) {
        if (progress === undefined) {
            progress = this.progress;
        }

        let offset = this.arc - this.arc * progress;

        if (!this.bg) {
            offset = this.arc - (this.arc - this.gap) * progress;
        }

        this.node.setAttributeNS(null, "data-progress", progress);
        this.node.setAttributeNS(null, "stroke-dashoffset", offset);

        this.progress = progress;
        this.offset = offset;
    }
}

class RProgress {
    start(to, from, duration) {
        this.frame = false;

        if (from === undefined) {
            from = this.config.progress;
        }

        if (duration === undefined) {
            duration = 5000;
        }

        let st = Date.now();

        // Scroll function
        const animate = () => {
            let progress,
                now = Date.now(),
                ct = now - st;

            // Cancel after allotted interval
            if (ct > duration) {
                cancelAnimationFrame(this.frame);
                this.setProgress(to, false);
                this.config.onChange.call(this, 100, ct, duration);
                this.config.onComplete.call(this, to);
                return;
            }

            progress = easings[this.config.easing](ct, from, to - from, duration);

            this.setProgress(progress, false);

            this.config.onChange.call(this, progress, ct, duration);

            // requestAnimationFrame
            this.frame = requestAnimationFrame(animate);
        };

        this.config.onStart.call(this);
        animate();
    }	
	
    pause() {
        cancelAnimationFrame(this.frame);
    }

    stop() {
        cancelAnimationFrame(this.frame);
        this.remove();
    }	

    render(element) {
        if (!this.rendered) {
            element =
                typeof element === "string" ? document.querySelector(element) : element;

            element.appendChild(this.container);
			
            this.setPosition();

            this.rendered = true;
        }
    }

    remove() {
        const parent = this.container.parentNode;
        if (this.rendered && parent) {
            parent.removeChild(this.container);

            this.rendered = false;
        }
    }

    show() {
        this.container.classList.remove("done");
    }

    hide() {
        this.container.classList.add("done");
    }    
}

/**
* RadialProgress Class
*/
class RadialProgress extends RProgress {
    constructor(config) {
        super();


        const defaultConfig = {
            r: 50,
            s: 10,
            x: 0,
            y: 0,
            cap: "butt",
            padding: 0,
            progress: 0,
            minAngle: 0,
            maxAngle: 360,
            rotation: 0,
            color: "rgba(255, 255, 255, 1.0)",
            bgColor: "rgba(0, 0, 0, 0.4)",
            easing: "easeLinear",
            onStart: () => {},
            onChange: () => {},
            onComplete: () => {},
            onTimeout: () => {},
        };

        this.config = Object.assign({}, defaultConfig, config);

        this.init();

        return this;
    }

    init() {
        const arc = this.config.maxAngle - this.config.minAngle;

        this.config.padding *= 2;
				
        this.config.w = (this.config.r * 2) + this.config.padding;
        this.config.h = (this.config.r * 2) + this.config.padding;

        this.svg = new Svg(this.config.w, this.config.h);

        this.dials = {
            bg: new Circle(
                this.config.r + (this.config.padding / 2),
                this.config.s + this.config.padding,
                this.config.minAngle,
                this.config.maxAngle,
                true
            ),
            fg: new Circle(
                this.config.r,
                this.config.s,
                this.config.minAngle,
                this.config.maxAngle
            )
        };

        if ( this.config.zone ) {
            this.zoneArc = (this.config.zone / 100) * arc;
            this.zonePos = getRandomInt(0, arc - this.zoneArc);

            const startPos = (this.zonePos / arc) * 100;
            this.zoneMin = startPos;
            this.zoneMax = startPos + this.config.zone;

            this.dials.zone = new Circle(
                this.config.r,
                this.config.s,
                0,
                this.zoneArc,
                true
            )
        }        

        this.svg.getNode().appendChild(this.dials.bg.getNode());
        this.svg.getNode().appendChild(this.dials.fg.getNode());

        if ( this.dials.zone ) {

            this.svg.getNode().appendChild(this.dials.zone.getNode());
            this.dials.zone.getNode().setAttributeNS(null, "stroke", "rgba(51, 105, 30, 1)"); 

            this.dials.zone.getNode().style.transform = `rotate(${
                this.zonePos
            }deg)`;

            this.dials.zone.getNode().style.transformOrigin = `50% 50% 0`;
        }


        const fgNode = this.dials.fg.getNode();
        fgNode.setAttributeNS(null, "cx", (this.config.w / 2));
        fgNode.setAttributeNS(null, "cy", (this.config.h / 2));
        fgNode.setAttributeNS(null, "stroke-linecap", this.config.cap);
        fgNode.setAttributeNS(null, "stroke", this.config.color);   
         
        this.dials.bg.getNode().setAttributeNS(null, "stroke", this.config.bgColor);


        const container = document.createElement("div");
        container.classList.add("ui-dial");

        const indicator = document.createElement("div");
        indicator.classList.add("ui-indicator");

        const label = document.createElement("div");
        label.classList.add("ui-label");

        this.setRotation(this.config.rotation);

        container.appendChild(this.svg.getNode());
        container.appendChild(indicator);
        container.appendChild(label);

        this.container = container;
        this.indicator = indicator;
        this.label = label;

        this.setPosition(this.config.x, this.config.y);
        this.setProgress();
    }

    setPosition(x, y) {
        this.config.x = x;
        this.config.y = y;

        const size = (this.config.r * 2);

        this.container.style.width = `${(this.config.r * 2) + this.config.padding}px`;
        this.container.style.height = `${(this.config.r * 2) + this.config.padding}px`;
        this.container.style.left = `${
            (this.config.x * window.innerWidth) - (size / 2) - (this.config.padding / 2)
        }px`;
        this.container.style.top = `${
            (this.config.y * window.innerHeight) - (size / 2) - (this.config.padding / 2)
        }px`;
    }

    setEndAngle(angle) {
        this.config.maxAngle = angle;

        this.dials.bg.maxAngle = angle;
        this.dials.bg.setArc();

        this.dials.fg.maxAngle = angle;
        this.dials.fg.setArc();

        this.dials.bg.setProgress();
        this.dials.fg.setProgress();
    }

    setRotation(angle) {
        this.config.rotation = angle;
        this.svg.getNode().style.transform = `rotate(${
            this.config.rotation - 90
        }deg)`;
    }

    setProgress(progress, e) {
        if (progress === undefined) {
            progress = this.config.progress;
        }

        this.dials.fg.setProgress(progress / 100);

        this.progress = progress;

        if (e === undefined) {
            this.config.onChange.call(this, progress);
        }
    }
}

class LinearProgress extends RProgress {
    constructor(config) {
        super();
		
        const defaultConfig = {
            w: 300,
            h: 10,
            s: 10,
            x: 0,
            y: 0,
            cap: "butt",
            padding: 0,
            progress: 0,
            color: "rgba(255, 255, 255, 1.0)",
            bgColor: "rgba(0, 0, 0, 0.4)",
            easing: "easeLinear",
            onStart: () => {},
            onChange: () => {},
            onComplete: () => {}
        };

        this.config = Object.assign({}, defaultConfig, config);
        this.progress = 0;

        this.init();

        return this;
    }

    init() {
        this.container = document.createElement("div");
        this.container.classList.add("linear-progress");

        this.bg = document.createElement("div");
        this.fg = document.createElement("div");
		
        this.bg.classList.add("linear-progress-bg");
        this.fg.classList.add("linear-progress-fg");

        this.label = document.createElement("div");
        this.label.classList.add("linear-progress-label");
		
        this.container.appendChild(this.bg);
        this.container.appendChild(this.fg);
        this.container.appendChild(this.label);
    }
	
    setPosition() {
        let contCss = `width:${this.config.w}px;height:${this.config.h}px;left:${this.config.x * window.innerWidth - this.config.w / 2}px;top:${this.config.y * window.innerHeight - this.config.h / 2}px;`;
        let bgCss = `background-color:${this.config.bgColor};padding:${this.config.padding}px;left:${-this.config.padding}px;top:${-this.config.padding}px;`;
		
        this.container.style.cssText = contCss;
		
        this.fg.style.backgroundColor = this.config.color;
		
        if ( this.config.cap == 'round' ) {
            this.fg.style.borderRadius = `${this.config.h / 2}px`
            this.fg.style.transform = "scale(1, 1)";
			
            bgCss += `border-radius:${this.config.h / 2 + this.config.padding}px;`;
        } else {
            this.fg.style.width = "100%";
        }
		

        this.bg.style.cssText = bgCss;
    }
	
    setProgress(progress, e) {
        if (progress === undefined) {
            progress = this.config.progress;
        }
		
        const p = (progress / 100);
		
        if ( this.config.cap == 'round' ) {
            this.fg.style.width = `${progress}%`;
        } else {
            this.fg.style.transform = `scale(${p}, 1)`;
        }
		
        this.progress = progress;

        if (e === undefined) {
            this.config.onChange.call(this, progress);
        }
    }
}

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min) + min);
}

const easings = {

    easeLinear: (t, b, c, d) => c * t / d + b,

    // ease-in
    easeInQuad: (t, b, c, d) =>
        c * (t /= d) * t + b,

    easeInCubic: (t, b, c, d) =>
        c * (t /= d) * t * t + b,

    easeInQuart: (t, b, c, d) =>
        c * (t /= d) * t * t * t + b,

    easeInQuint: (t, b, c, d) =>
        c * (t /= d) * t * t * t * t + b,

    easeInSine: (t, b, c, d) =>
        -c * Math.cos(t / d * (Math.PI / 2)) + c + b,

    easeInExpo: (t, b, c, d) =>
        t == 0 ? b : c * Math.pow(2, 10 * (t / d - 1)) + b,

    easeInCirc: (t, b, c, d) =>
        -c * (Math.sqrt(1 - (t /= d) * t) - 1) + b,

    easeInElastic: (t, b, c, d) => {
        var s = 1.70158;
        var p = 0;
        var a = c;
        if (t == 0) return b;
        if ((t /= d) == 1) return b + c;
        if (!p) p = d * .3;
        if (a < Math.abs(c)) {
            a = c;
            var s = p / 4;
        } else var s = p / (2 * Math.PI) * Math.asin(c / a);
        return -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
    },

    easeInBack: (t, b, c, d, s) => {
        if (s == undefined) s = 1.70158;
        return c * (t /= d) * t * ((s + 1) * t - s) + b;
    },


    // ease-out

    easeOutQuad: (t, b, c, d) =>
        -c * (t /= d) * (t - 2) + b,

    easeOutCubic: (t, b, c, d) =>
        c * ((t = t / d - 1) * t * t + 1) + b,

    easeOutQuart: (t, b, c, d) =>
        -c * ((t = t / d - 1) * t * t * t - 1) + b,

    easeOutQuint: (t, b, c, d) =>
        c * ((t = t / d - 1) * t * t * t * t + 1) + b,

    easeOutSine: (t, b, c, d) =>
        c * Math.sin(t / d * (Math.PI / 2)) + b,

    easeOutExpo: (t, b, c, d) =>
        t == d ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b,

    easeOutCirc: (t, b, c, d) =>
        c * Math.sqrt(1 - (t = t / d - 1) * t) + b,

    easeOutElastic: (t, b, c, d) => {
        var s = 1.70158;
        var p = 0;
        var a = c;
        if (t == 0) return b;
        if ((t /= d) == 1) return b + c;
        if (!p) p = d * .3;
        if (a < Math.abs(c)) {
            a = c;
            var s = p / 4;
        } else var s = p / (2 * Math.PI) * Math.asin(c / a);
        return a * Math.pow(2, -10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b;
    },

    easeOutBack: (t, b, c, d, s) => {
        if (s == undefined) s = 1.70158;
        return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
    },

    easeOutBounce: (t, b, c, d) => {
        if ((t /= d) < (1 / 2.75)) {
            return c * (7.5625 * t * t) + b;
        } else if (t < (2 / 2.75)) {
            return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b;
        } else if (t < (2.5 / 2.75)) {
            return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b;
        } else {
            return c * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b;
        }
    },


    // ease-in-out
    easeInOutQuad: (t, b, c, d) => {
        if ((t /= d / 2) < 1) return c / 2 * t * t + b;
        return -c / 2 * ((--t) * (t - 2) - 1) + b;
    },

    easeInOutCubic: (t, b, c, d) => {
        if ((t /= d / 2) < 1) return c / 2 * t * t * t + b;
        return c / 2 * ((t -= 2) * t * t + 2) + b;
    },

    easeInOutQuart: (t, b, c, d) => {
        if ((t /= d / 2) < 1) return c / 2 * t * t * t * t + b;
        return -c / 2 * ((t -= 2) * t * t * t - 2) + b;
    },

    easeInOutQuint: (t, b, c, d) => {
        if ((t /= d / 2) < 1) return c / 2 * t * t * t * t * t + b;
        return c / 2 * ((t -= 2) * t * t * t * t + 2) + b;
    },

    easeInOutSine: (t, b, c, d) =>
        -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b,

    easeInOutExpo: (t, b, c, d) => {
        if (t == 0) return b;
        if (t == d) return b + c;
        if ((t /= d / 2) < 1) return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
        return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b;
    },

    easeInOutCirc: (t, b, c, d) => {
        if ((t /= d / 2) < 1) return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b;
        return c / 2 * (Math.sqrt(1 - (t -= 2) * t) + 1) + b;
    },

    easeInOutElastic: (t, b, c, d) => {
        var s = 1.70158;
        var p = 0;
        var a = c;
        if (t == 0) return b;
        if ((t /= d / 2) == 2) return b + c;
        if (!p) p = d * (.3 * 1.5);
        if (a < Math.abs(c)) {
            a = c;
            var s = p / 4;
        } else var s = p / (2 * Math.PI) * Math.asin(c / a);
        if (t < 1) return -.5 * (a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
        return a * Math.pow(2, -10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p) * .5 + c + b;
    },

    easeInOutBack: (t, b, c, d, s) => {
        if (s == undefined) s = 1.70158;
        if ((t /= d / 2) < 1) return c / 2 * (t * t * (((s *= (1.525)) + 1) * t - s)) + b;
        return c / 2 * ((t -= 2) * t * (((s *= (1.525)) + 1) * t + s) + 2) + b;
    },
};

const ui = document.getElementById('rprogress');
let running = false;
let customDial = false
let staticDial = false
let miniGame = false

window.onData = function (data) {
    if ( data.MiniGame ) {
        if ( !miniGame && !running ) {
            miniGame = new RadialProgress({
                r: data.Radius,
                s: data.Stroke,
                x: data.x,
                y: data.y,
                color: data.Color,
                bgColor: data.BGColor,
                rotation: data.Rotation,
                maxAngle: data.MaxAngle,
                progress: data.From,
                zone: data.Zone,
                onStart: function() {
                    running = true;
                },                
                onComplete: function(progress) {
                    if ( progress >= 100 ) {
                        this.start(0, 100, data.Duration);
                    } else {
                        this.start(100, 0, data.Duration);
                    }               
                }          
            });         

            miniGame.render(ui);

            miniGame.start(data.To, data.From, data.Duration);
        }
    } else {
        if (data.display && !running) {
            if ( data.Type == 'linear' ) {
                customDial = new LinearProgress({
                    w: data.Width,
                    h: data.Height,
                    x: data.x,
                    y: data.y,
                    padding: data.Padding,
                    cap: data.Cap,                
                    color: data.Color,
                    bgColor: data.BGColor,
                    progress: data.From,
                    easing: data.Easing,
                    onStart: function() {
                        running = true;

                        this.label.textContent = data.Label;

                        PostData("progress_start")
                    },    
                    onComplete: function () {
                        this.label.textContent = "";

                        PostData("progress_complete");

                        this.hide();

                        setTimeout(() => {
                            this.remove();
                        }, 1000)
                    
                        running = false;
                    }                    
                });
            } else if ( data.Type == 'radial' || !data.Type ) {
                customDial = new RadialProgress({
                    r: data.Radius,
                    s: data.Stroke,
                    x: data.x,
                    y: data.y,
                    padding: data.Padding,
                    cap: data.Cap,                
                    color: data.Color,
                    bgColor: data.BGColor,
                    rotation: data.Rotation,
                    maxAngle: data.MaxAngle,
                    progress: data.From,
                    easing: data.Easing,
                    onStart: function() {
                        running = true;

                        this.container.classList.add(`label-${data.LabelPosition}`);
                        this.label.textContent = data.Label;

                        PostData("progress_start")
                    },
                    onChange: function(progress, t, duration) {
                        if ( data.ShowTimer ) {
                            this.indicator.textContent = `${((duration - t) / 1000).toFixed(2)}s`;
                        }

                        if ( data.ShowProgress ) {
                            this.indicator.textContent = `${Math.ceil(progress)}%`;
                        }                
                    },     
                    onComplete: function () {
                        PostData("progress_complete");

                        this.indicator.textContent = "";
                        this.label.textContent = "";
                        this.hide();

                        setTimeout(() => {
                            this.remove();
                        }, 1000)
                    
                        running = false;
                    }
                });
            }

            customDial.render(ui);

            customDial.start(data.To, data.From, data.Duration);
        }

        if ( data.static ) {
            if ( !staticDial ) {
                staticDial = new RadialProgress({
                    r: data.Radius,
                    s: data.Stroke,
                    x: data.x,
                    y: data.y,
                    padding: data.Padding,
                    cap: data.Cap,
                    color: data.Color,
                    bgColor: data.BGColor,
                    rotation: data.Rotation,
                    maxAngle: data.MaxAngle,
                    progress: data.From,
                    onChange: function(progress) {
                        if ( data.ShowProgress ) {
                            this.indicator.textContent = `${Math.ceil(progress)}%`;
                        }                
                    },                 
                });

                staticDial.container.classList.add(`label-${data.LabelPosition}`);
                staticDial.label.textContent = data.Label;            
            } else {
                if (data.show) {
                    staticDial.render(ui);
                }
            
                if (data.hide) {
                    staticDial.remove();
                }               

                if ( data.progress !== false ) {
                    staticDial.setProgress(data.progress)
                }

                if (data.destroy) {
                    staticDial.remove();
                    staticDial = false;
                }             
            }              
        }
    }

    if (data.stop) {
        running = false;

        if ( miniGame ) {
            miniGame.stop();
            miniGame = false
        } else if ( customDial ) {
            customDial.stop();
            customDial = false
        }

        PostData("progress_stop");
    }
};

window.onload = function (e) {
    window.addEventListener('message', function (event) {
        onData(event.data);
    });

    window.addEventListener("keydown", e => {
        if ( e.key == " " ) {
            if ( miniGame && running ) {
                miniGame.pause();
                
                PostData("progress_minigame_input", {
                    success: miniGame.progress > miniGame.zoneMin && miniGame.progress < miniGame.zoneMax
                })

                setTimeout(() => {
                    miniGame.hide();
                    setTimeout(() => {
                        running = false;
                        miniGame.stop();
                        miniGame = false;

                        PostData("progress_minigame_complete");
                    }, 1000)
                }, 1000)
            }                 
        } 
    });     
};

function PostData(type, obj) {
    if ( obj === undefined ) {
        obj = {}
    }
    fetch(`https://${GetParentResourceName()}/${type}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(obj)
    }).then(resp => resp.json()).then(resp => resp).catch(error => console.log('RPROGRESS FETCH ERROR! ' + error.message));  
}

