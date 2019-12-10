<div class="row text-left">
    {#if state.current == "TRADING"}
        {#each teams as team, i}
            {#if i != state.team}
                <button class="col-sm-1-4 text-left btn btn-warning p-4 m-4" on:click={() => tradeWith(i)}>
                    <h1>{team.name}</h1>
                    <h3>Members:</h3>
                    <ul>
                        {#each team.members as member}
                            <li>{member}</li>
                        {/each}
                    </ul>
                    <h3>Score:</h3>
                    <h4>{team.score}</h4>
                </button>
            {/if}
        {/each}
    {:else}
        {#each teams as team, i}
            <button class="col-sm-1-4 text-left btn btn-{spinningTeam == i ? "success" : "primary"} p-4 m-4" on:click={() => allowSpin(i)}>
                <h1>{team.name}</h1>
                <h3>Members:</h3>
                <ul>
                    {#each team.members as member}
                        <li>{member}</li>
                    {/each}
                </ul>
                <h3>Score:</h3>
                <h4>{team.score}</h4>
            </button>
        {/each}
    {/if}

</div>
<button on:click={endGame} class="btn btn-danger">End Game</button>
<Canvas sketch={sketch}/>
<button on:click={spin} class="btn btn-{spinningTeam != null ? "success" : "secondary"} m-5" id="spin">Spin</button>
<br>
<br>
<h3>{display ? display : ""}</h3>

<script>
 import Canvas from "./canvas.svelte";
 import Rails from 'rails-ujs'
 const svelte = require('svelte/compiler');

 let wedges = JSON.parse(window.$("#game_data").attr("data-wheel"));

 let wheelID = window.$("#game_data").attr("data-wheel-id");
 let gameID = window.$("#game_data").attr("data-game-id");

 let state = {
     current: "TEAM_SELECT",
     team: 0
 }

 let selectedTeamClass;

 let numOfWedges = wedges.length;
 let teams = JSON.parse(window.$("#game_data").attr("data-teams"));

 let display;
 let spinningTeam;

 let width = 300;
 let textPadding = 50;
 let radius = width / 2;

 let angle = 0;

 let velocity = 0;

 let spinVelocity = 20;
 let resistance = .4;

 function allowSpin(teamIndex) {
     if (state.current != "SPINNING") {
         spinningTeam = teamIndex;
     }

 }

 function tradeWith(teamIndex) {
     let tradingTeamScore = teams[state.team].score;
     let otherTeamScore = teams[teamIndex].score;

     teams[state.team].score = otherTeamScore;
     teams[teamIndex].score = tradingTeamScore;

     state.current = "TEAM_SELECT"
     state.team = 0;
     display = "";
 }

 function spin() {
     if (state.current != "SPINNING" && spinningTeam != null) {
         state.current = "SPINNING"
         state.team = spinningTeam
         velocity = Math.floor(Math.random() * (spinVelocity - 10)) + (spinVelocity + 10);
     }
 }

 function endGame() {
     let victoriousTeam = 0;
     for (let i = 0; i < teams.length; i++) {
         if (teams[i].score > teams[victoriousTeam].score) {
             victoriousTeam = i;
         }
     }

     Rails.ajax({
         url: "/game/end",
         type: "POST",
         dataType: "json",
         data: "game=" + JSON.stringify({
             "game_id": parseInt(gameID),
             "teams": teams,
             "wheel_id": parseInt(wheelID),
             "victorious_team": victoriousTeam
         })
     })
 }

 let sketch = function(p5) {

     function wheelLanded() {
         for (let i = wedges.length - 1; i >= 0; i--) {
             let sectionAngle = 360 / wedges.length;
             if (angle >= (i + 1) * sectionAngle - sectionAngle && angle < (i + 1) * sectionAngle) {
                 display = wedges[i].text;
                 if (wedges[i].special == "None") {
                     teams[spinningTeam].score += wedges[i].value;
                 } else if (wedges[i].special == "Subtract") {
                     teams[spinningTeam].score -= wedges[i].value;
                 } else if (wedges[i].special == "Bankrupt") {
                     if (teams[spinningTeam].score > 0) {
                        teams[spinningTeam].score = 0;
                     }
                 } else if (wedges[i].special == "Trade Points") {
                     state.current = "TRADING";
                     state.team = spinningTeam;
                     display = "Who would you like to trade with " + teams[state.team].name + "?" + " Your current score is " + teams[state.team].score;
                 }


                 teams = teams;
                 spinningTeam = null;
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

         if (state.current == "SPINNING") {
             velocity -= p5.sq(resistance);

             if (velocity <= 0) {
                 state.current = "TEAM_SELECT"
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
     font-family: Arial, Helvetica, sans-serif;

     background: #2d2e30;
     color: white;
 }

 .row {
     margin-left: 0;
     margin-right: 0;
 }
</style>
