function createListParticipant(){
  const input = document.getElementById('participantsToCreate')
  if (input) {
    if (input.value) {
      setDataParticipant(input.value)
    }
    const usersToAdd = document.querySelectorAll(".userToAdd")
    const usersToRemove = document.querySelectorAll(".userToRemove")
    usersToAdd.forEach((user) => {
      user.addEventListener('click', function(){
        addParticipantInTheInput(user, input)
        setAddAndRemovePart("user_added_", user)
        setAddAndRemovePart("user_edit_", user)
        countTotal(input)
      });
    });
    usersToRemove.forEach((user) => {
      user.addEventListener('click', function(){
        removeParticipantFromTheInput(user, input)
        setAddAndRemovePart("user_removed_", user)
        setAddAndRemovePart("user_edit_", user)
        countTotal(input)
      });
    });
  }
}
export { createListParticipant }

function setDataParticipant(value) {
  var test = Array.from(value)
  var j
  for (j = 0; j < test.length ; j++) {
    var idRemove = "user_removed_" + test[j]
    var idAdd = "user_added_" + test[j]
    var idDash = "user_edit_" + test[j]
    var divIdRemove = document.getElementById(idRemove)
    var divIdAdd = document.getElementById(idAdd)
    var divIdDash = document.getElementById(idDash)
    if (divIdRemove) {
      divIdRemove.classList.add('hidden')
    }
    if (divIdAdd) {
      divIdAdd.classList.remove('hidden')
    }
    if (divIdDash) {
      divIdDash.classList.remove('hidden')
    }
  };
}

function addParticipantInTheInput(user, input){
  var newElement = user.dataset.user
  var values = input.value
  var elements = Array.from(values)
  if (elements.indexOf(newElement) === -1) {
    if (input.value.length === 0) {
      input.value = newElement
    } else {
      var newArray = values + "," + newElement
      input.value = newArray.split(",,").join("")
    }
  };
}

function removeParticipantFromTheInput(user, input){
  var newElement = user.dataset.user
  var values = input.value
  var elements = Array.from(values)
  input.value = elements.filter(element => element !== newElement)
}

function setAddAndRemovePart(tagId, user){
  user.classList.add('hidden')
  let id = tagId + user.dataset.user
  let user_added = document.getElementById(id)
  user_added.classList.toggle('hidden')
}

function countTotal(input){
  var i
  var count = 0;
  for (i = 0; i < input.value.length ; i++) {
    if (input.value[i] != ",") {
      count += 1
    };
  };
  const score = document.getElementById('totalInvite')
  score.innerText = count
}
