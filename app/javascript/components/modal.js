function revealModal() {
  function triggerModal(event){
    let targetModalID = event.currentTarget.dataset.target
    let targetdate = event.currentTarget.dataset.date
    console.log(targetdate)
    let targetModal = document.getElementById(targetModalID)

    targetModal.style.display = "block";

    let close = "close_" + targetModalID
    let span = document.getElementById(close);
    span.onclick = function() {
      targetModal.style.display = "none";
    }

    window.onclick = function(event) {
      if (event.target == targetModal) {
          targetModal.style.display = "none";
      }
    }



  }

  const modalButtonsList = document.querySelectorAll('.modal-button')
  if ( modalButtonsList != null) {
    modalButtonsList.forEach((button) => {
      button.addEventListener("click", triggerModal);
    })
  }
}


export { revealModal }

