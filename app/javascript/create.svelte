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
    <button class="btn bg-gradient-danger text-light" on:click={() => removeTeamMember(i)}>Remove Team Member</button>
    <br>
  {/each}
  <br>
  <button class="btn bg-gradient-primary text-light" on:click={addTeamMember}>Add New Member</button>
  <button class="btn bg-gradient-primary text-light" on:click={addTeam}>Add Team</button>
</div>

<div class="teams">
  {#each teams as team, i}
    <div class="team">
      <h3>{team.name}</h3>
      <p>Members:</p>
      {#if team.members}
        {#each team.members as member}
          <p class="member">{member}</p>
        {/each}
      {/if}
      <button on:click={() => removeTeam(i)}>Remove Team</button>
      <button on:click={() => editTeam(i)}>Edit</button>
    </div>
  {/each}
</div>
<br>
<br>


<!-- Wheel Editing -->

<h3 class="p-3">Wheel Sections</h3>
<div class="p-3">
  <input type="range" on:change={updateWedges} bind:value={numOfWedges} max=10 min=4 step=2>
  <div class="wedges">
    {#each wedges as wedge}
      <div class="p-2 bg-primary rounded">
        <br>
        Text:<input bind:value={wedge.text}>
        <br>
        Special Case:
        <br>
        <div class="btn-group btn-group-toggle" data-toggle="buttons">
          {#each specialOptions as option}
            <br>
            <label class="p-2"><input type="radio" value={option} name={wedge.id} bind:group={wedge.special}> {option}</label>
            <br>
          {/each}
        </div>
        <br>
        {#if true}
        Point Value:<input type="number" bind:value={wedge.value}>
        <br>
        {/if}
      </div>
      <br>
    {/each}
  </div>
</div>

<button class="btn btn-success">Create Game</button>

<script>
  let teams = [];
  let newTeam = {
    name: "",
    members: []
  };

  let specialOptions = ["Trade Points", "Bankrupt", "None"]

  let numOfWedges = 4;
  let wedges = [];
  for (let i = 0; i < numOfWedges; i++) {
    wedges.push({
      text: "",
      special: "None",
      id: i,
      value: 0
    })
  }

  let newTeamMembers = [""];

	function updateWedges() {
    let newWedges = [];
		for (let i = 0; i < numOfWedges; i++) {
			newWedges.push({
				text: wedges[i].text,
        special: wedges[i].special,
        id: wedges[i].id,
        value: wedges[i].value
      });
		}
    wedges = newWedges;
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
      newTeam = {
        name: "",
        members: []
      };
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

  .blue-btn {
    font-size: 1rem;
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