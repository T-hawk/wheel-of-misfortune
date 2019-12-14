<h1 class="display-4">New Game</h1>
<br>
<br>
<br>
<!-- Team Editing -->
<div class="p-4">
  <label class="">Team name:<input type="text" class="form-control" bind:value={newTeam.name}></label>
  <br>

  <label>Members:</label>
  <br>
  {#each newTeamMembers as member, i}
    <label><input class="form-control" type="text" bind:value={member}></label>
    <button class="btn btn-outline-danger text-light" on:click={() => removeTeamMember(i)}>Remove Team Member</button>
    <br>
  {/each}
  <br>
  <button class="btn bg-gradient-primary text-light" on:click={addTeamMember}>Add New Member</button>
  <button class="btn bg-gradient-success text-light" on:click={addTeam}>Add Team</button>
</div>

<div class="teams">
  {#each teams as team, i}
    <div class="bg-gradient-primary rounded p-3 m-3 text-left">
      <h3>{team.name}</h3>
      <p>Members:</p>
      {#each team.members as member}
        <p class="member">{member}</p>
      {/each}
      <button class="btn btn-outline-warning text-light" on:click={() => editTeam(i)}>Edit</button>
      <button class ="btn btn-outline-danger text-light" on:click={() => removeTeam(i)}>Remove Team</button>
    </div>
  {/each}
</div>
<br>
<br>

<!-- Wheel Editing -->

<h3 class="p-3">Wheel Sections</h3>
<div class="p-3" align="left">
    Presets:<select bind:value={currentWheelPreset} on:change={() => changeWheel(currentWheelPreset)}>
        {#each presetWheels as wheel}
            <option value={wheel}>{wheel.text}</option>
        {/each}
    </select>
    <br>
  <label>Number of Sections:<input type="range" on:change={updateSections} bind:value={numOfSections} max=12 min=4 step=2></label>
  <div class="wedges">
    {#each wheel.sections as section}
      <div class="p-2 w-50 bg-primary rounded">
        <br>
        Text:<input bind:value={section.text}>
        <br>
        Special Case:
        <br>
        <div class="btn-group btn-group-toggle" data-toggle="buttons">
          {#each specialOptions as option}
            <br>
            <label class="p-2"><input type="radio" value={option} name={section.id} bind:group={section.special}> {option}</label>
            <br>
          {/each}
        </div>
        <br>
        {#if section.special != "Trade Points" && section.special != "Bankrupt"}
        Point Value:<input type="number" bind:value={section.value}>
        <br>
        {/if}
      </div>
      <br>
    {/each}
  </div>
</div>

{#if errors}
    {#each errors as error}
        {#if error != ""}
            <div class="bg-danger p-2 m-3 w-25 rounded">{error}</div>
        {/if}
    {/each}
{/if}
<button class="btn btn-success" on:click={createGame}>Create Game</button>
<br>
<br>

<script>
 class Wheel {
     constructor(sections) {
         this.sections = sections
     }

     addSection() {
         this.sections.push({
             text: "",
             special: "Add",
             id: this.sections.length,
             value: 0
         })
     }

     isInvalid() {
         for (let i = 0; i < this.sections.length; i++) {
             if (this.sections[i].text == "") {
                 return "The text in wheel section " + (i + 1) + " was empty!"
             }

             if (this.sections[i].value == 0 && this.sections[i].special == "Add") {
                 return "Wheel section " + (i + 1) + ", it is set to add nothing!"
             }

             return ""
         }
     }
 }

 class Team {
     constructor(name, members) {
         this.name = name;
         this.members = members;

         this.score = 0;
     }
 }

 let defaultWheel = JSON.parse(window.$("#default_wheel").attr("data-default-wheel"));
 let christmasWheel = JSON.parse(window.$("#default_wheel").attr("data-christmas-wheel"));
 let presetWheels = [
     {text: "Custom", wheelSections: [{"text": "", "special": "Add", "value":0},{"text": "", "special": "Add", "value":0},{"text": "", "special": "Add", "value":0},{"text": "", "special": "Add", "value":0}]},
     {text: "Default", wheelSections: defaultWheel}, {text: "Christmas", wheelSections: christmasWheel}];
 let currentWheelPreset = "Custom";
 let wheelId;

  let errors = [];

  let teams = [];
  let newTeam = new Team("", []);
  import Rails from 'rails-ujs'

  let specialOptions = ["Trade Points", "Bankrupt", "Subtract", "Add"]

 let numOfSections = 4;

 let wheel = new Wheel([]);

 for (let i = 0; i < numOfSections; i++) {
      wheel.addSection();
  }


 function teamsAreEmpty(array) {
     if (!array.length) {
         return "There are no teams!";
     }

     return "";
 } 

 function arrayIsEmpty(array) {

     for (let i = 0; i < array.length; i++) {
         if (array[i] != "") {
             return false;
         }
     }

     return true;
 }

  let newTeamMembers = [""];

  function createGame() {
    errors = [];
    errors.push(teamsAreEmpty(teams));
    errors.push(wheel.isInvalid());

    if (arrayIsEmpty(errors)) {
        Rails.ajax({
            url: "game/create",
            type: "POST",
            dataType: "json",
            data: "game=" + JSON.stringify({
            "teams": teams,
            "wheel": wheel.sections,
            "wheel_id": wheelId
            })
        });
        errors = [];
    }
  }

 function changeWheel(newWheel) {
     wheel.sections = newWheel.wheelSections;
     numOfSections = newWheel.wheelSections.length;
 }

	function updateSections() {
    let newSections = [];
		for (let i = 0; i < numOfSections; i++) {
      if (i < wheel.sections.length) {
        newSections.push({
          text: wheel.sections[i].text,
          special: wheel.sections[i].special,
          id: wheel.sections[i].id,
          value: wheel.sections[i].value
        });
      } else {
        newSections.push({
          text: "",
          special: "Add",
          id: i,
          value: 0
        })
      }
		}
    wheel.sections = newSections;
	}

  function editTeam(index) {
    newTeam = teams[index];
    newTeamMembers = teams[index].members;
    removeTeam(index);
  }

  function removeTeam(index) {
    teams.splice(index, 1);
    teams = teams;
  }

  function addTeamMember() {
    newTeamMembers.push("");
    newTeamMembers = newTeamMembers;
  }
  function removeTeamMember(index) {
    newTeamMembers.splice(index, 1);
    newTeamMembers = newTeamMembers;
  }

  function addTeam() {
    if (newTeam.name && newTeam.members) {
      newTeam.members = newTeamMembers;
      teams.push(newTeam)
      teams = teams;
      newTeam = new Team("", [])
      newTeamMembers = [""];
      newTeam = newTeam;
    }
  }
</script>

<style>
  :global(body) {
    color: white;
    background: #2d2e30;
  }

  h1 {
    text-align: center;
  }

  .teams {
    margin: 0;
    padding: 0;
    list-style-type: none;
    display: flex;
    flex-flow: row wrap;
  }

  .team {
    background-image: linear-gradient(rgba(4,150,255,0.63), rgba(4,150,255,1));
    width: 300px;
    margin: 10px;
    text-align: left;

    padding: 10px
  }

  .team .member {
    padding-left: 20px;
  }

  .team h3 {
    text-align: center;
  }

</style>
