function toggleClass(){
  const btn = document.getElementById('hiddenBtn')
  const secondDate = document.getElementById('secondDate')
  if (btn) {
    var divs = secondDate.querySelectorAll('.form-group')
    var text = document.getElementById('toHidden')
    btn.addEventListener('click', function(){
      divs.forEach((div) => {
        div.classList.toggle('hidden')
      })
      text.classList.toggle('hidden')
    })

  }
}



export {toggleClass}
