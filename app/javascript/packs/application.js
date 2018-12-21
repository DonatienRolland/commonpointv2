import "../plugins/flatpickr"

import "bootstrap";

import "../components/equalHeight"

import { importAvatar } from "../components/displayPicture";
importAvatar();

import { revealModal } from "../components/modal";
revealModal();

import { toggleClass } from "../components/addClass";
toggleClass();

import { createListParticipant } from "../components/participations";
createListParticipant();

import { addNumber } from "../components/addNumber";
addNumber();

import { tabWithOutNewData } from "../components/tabWithOutNewData";
tabWithOutNewData();
