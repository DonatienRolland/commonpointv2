import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import { French } from "flatpickr/dist/l10n/fr.js"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

flatpickr(".datepicker", {
  enableTime: false,
  mode: "range",
  dateFormat: "Y-m-d",
  inline: true
})



flatpickr(".onlydatepicker", {
  enableTime: false,
  minDate: "today",
  altFormat: "D j F Y",
  dateFormat: "d/m/Y",
  allowInput: true,
  noCalendar: false,
  "locale": French,
})

flatpickr(".onlyhourpicker", {
  enableTime: true,
  noCalendar: true,
  dateFormat: "H:i",
  minuteIncrement: 5,
  time_24hr: true
})
