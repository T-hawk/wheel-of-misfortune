<h1>Wheel of Misfortune</h1>
<Canvas sketch={sketch}/>
<button on:click={spin} id="spin">Spin</button>
<br>
<br>
<h3>{previousSpin ? previousSpin : ""}</h3>



<script>
	import Canvas from "./canvas.svelte";

	let numOfWedges = 4;
  let wedges = [];

  let teams;

  let previousSpin;

  let width = 300;
  let textPadding = 50;
  let radius = width / 2;

  let angle = 0;

  let velocity = 0;
  let spinning = false;

  let spinVelocity = 20;
  let resistance = .4;

	for (let i = 0; i < numOfWedges; i++) {
		wedges.push({
      text: "" + i,
      special: "None",
      id: i,
			value: 0
		});
  }

  function spin() {
    if (!spinning) {
      spinning = true;
      velocity = Math.floor(Math.random() * (spinVelocity - 10)) + (spinVelocity + 10);
    }
  }

	let sketch = function(p5) {

    function wheelLanded() {
        for (let i = wedges.length - 1; i >= 0; i--) {
          let sectionAngle = 360 / wedges.length;
          if (angle >= (i + 1) * sectionAngle - sectionAngle && angle < (i + 1) * sectionAngle) {
            previousSpin = wedges[i].text;
          }
        }
    }

		p5.setup = () => {
			let canvas = p5.createCanvas(400, 400);
      // canvas.position(p5.WIDTH / 2, 20)
      p5.strokeWeight(0);

      p5.textAlign(p5.LEFT, p5.CENTER)
      p5.rectMode(p5.CENTER)
    }

		p5.draw = () => {

			p5.clear();
			p5.background(0, 0, 0, 0);

      p5.translate(200, 200)

      if (spinning) {
        velocity -= p5.sq(resistance);

        if (velocity <= 0) {
          spinning = false;
          velocity = 0;
          wheelLanded();
        }

        angle += velocity;
      }

      if (360 % angle == 360) {
        angle = angle - 360;
      }

      p5.push();
      p5.angleMode(p5.DEGREES);
      p5.rotate(angle - 90 - 360 / wedges.length);
      p5.angleMode(p5.RADIANS);

			for (let i = wedges.length - 1; i >= 0; i--) {
				p5.rotate(p5.TWO_PI / wedges.length);
				if (i % 2 == 0) {
					p5.fill("#4287f5");
				} else {
					p5.fill("#6b2fa1");
				}
				p5.arc(0, 0, width, width, 0, p5.TWO_PI / wedges.length);
				p5.fill(255);
        p5.rotate((p5.TWO_PI / wedges.length) / 2);
				p5.text(wedges[i].text, textPadding * 2, 0, radius - textPadding, radius - textPadding)
				p5.rotate(-(p5.TWO_PI / wedges.length) / 2);
      }
      p5.pop();

      p5.fill(255);
      p5.rect(0, -radius, 10, 30);
      p5.ellipse(0, 0, 25)
		}
	}
</script>

<style>
	:global(body) {
		text-align: center;
		width: 100%;
    font-family: Arial, Helvetica, sans-serif;

    background: #2d2e30;
    color: white;
	}

  button {
    font-size: 2rem;
    color: white;

    border: none;
    border-radius: 5px;

    background-image: linear-gradient( 0.2deg,  rgba(51,204,255,1) 4.8%, rgba(51,102,255,1) 85.5% );
  }
</style>
