function addNumber(){
  const steppers = document.querySelectorAll('.input-stepper')
  if (steppers) {
    steppers.forEach((stepper) => {
      const add = stepper.querySelector('.minus')
      const plus = stepper.querySelector('.plus')
      const input = stepper.getElementsByTagName('input')[0]
      add.addEventListener('click', function(){
      var currentValue = parseInt(input.value)
       if ( currentValue ) {
          currentValue -= 1
          input.value = ""
          input.value = currentValue
        } else {
          input.value -= 1
        }
      })
      plus.addEventListener('click', function(){
      var currentValue = parseInt(input.value)
        if ( currentValue ) {
          currentValue += 1
          input.value = ""
          input.value = currentValue
        } else {
          input.value += 1
        }
      })
    })
  }
}

export { addNumber }
