<h1>Wheel of Misfortune</h1>
<Canvas sketch={sketch}/>
{#if editMode}
  <input type="range" on:change={updateWedges} bind:value={numOfWedges} max=12 min=4 step=2>
  <div class="wedges">
    {#each wedges as wedge}
      <br>
      Text:<input bind:value={wedge.text}>
      <br>
      Special Case:
      {#each specialOptions as option}
        <br>
      	<label><input type="radio" value={option} name={wedge.id} bind:group={wedge.special}> {option}</label>
        <br>
      {/each}
      <br>
      {#if true}
      Point Value:<input type="number" bind:value={wedge.value}>
      <br>
      {/if}
    {/each}
  </div>
  <button on:click={toggleEditMode}>Done Editing Wheel</button>
{:else}
  <button on:click={toggleEditMode}>Edit Wheel</button>
{/if}


<script>
	import Canvas from "./canvas.svelte";

	let numOfWedges = 4;
  let wedges = [];
  let specialOptions = [
    "Bankrupt",
    "Trade Points",
    "None"
  ]

  
  let width = 300;
  let textPadding = 50;
  let radius = width / 2;

  let editMode = false;

	for (let i = 0; i < numOfWedges; i++) {
		wedges.push({
      text: "",
      special: "None",
      id: i,
			value: 0
		});
  }
  
  function toggleEditMode() {
    if (editMode) {
      editMode = false;
    } else {
      editMode = true;
    }
  }

	function updateWedges() {
		wedges = [];
		for (let i = 0; i < numOfWedges; i++) {
			wedges.push({
				text: "",
        special: "None",
        id: i,
        value: 0
			});
		}
	}

	let sketch = function(p5) {
		p5.setup = () => {
			p5.createCanvas(400, 400);
      p5.strokeWeight(0);

      p5.textAlign(p5.LEFT, p5.CENTER)
      p5.rectMode(p5.CENTER)
		}

		let i = 0;
		let angle = 0;

		p5.draw = () => {
			i = p5.HALF_PI;
			angle += 0.01;
			if (i > p5.TWO_PI) {
				i = 0;
			}
			p5.clear();
			p5.background(0, 0, 0, 0);

			p5.translate(200, 200)

			p5.rotate(angle);

			for (let i = 0; i < wedges.length; i++) {
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
		}
	}
</script>

<style>
	:global(body) {
		text-align: center;
		width: 100%;
    font-family: Arial, Helvetica, sans-serif;
	}

	.wedges {
		text-align: left;
	}
</style>