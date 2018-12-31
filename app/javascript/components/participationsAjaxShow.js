function participationsAjaxShow(){
  const changingBlocks = document.querySelectorAll('.divStatus')
  const actualStatu = document.getElementById('statusParticipant')

  if (changingBlocks) {
    changingBlocks.forEach((changingBlock) => {
      const divStatus = changingBlock.querySelectorAll('.changingStatus')
      divStatus.forEach((divStatu) => {
        divStatu.addEventListener('click', function() {
          var sendValue = {
            participant_id: changingBlock.dataset.participant,
            status: JSON.parse(divStatu.dataset.status)
          }
          $.ajax({
            url: changingBlock.dataset.url,
            type: "PUT",
            data: sendValue,
            success: function() {
              if (JSON.parse(divStatu.dataset.status)) {
                divStatu.dataset.status = false
                divStatu.innerText = "quitter"
                if (actualStatu) {
                  actualStatu.innerHTML = "<p>je participe</p>"
                }
              } else {
                divStatu.dataset.status = true
                divStatu.innerText = "s'inscrire"
                if (actualStatu) {
                  actualStatu.innerHTML = "<p>je ne participe pas</p>"
                }
              }
            }
          });
        })
      })
    })

  }
}


export { participationsAjaxShow }
