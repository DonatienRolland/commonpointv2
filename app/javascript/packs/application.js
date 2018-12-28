import "../plugins/flatpickr"

import "bootstrap";

import "../components/equalHeight"

import { importAvatar } from "../components/displayPicture";
importAvatar();

import { revealModal } from "../components/modal";
revealModal();

import { toggleClass } from "../components/addClass";
toggleClass();

// import { createListParticipant, switchPublicPrive } from "../components/participations";
// createListParticipant();
// switchPublicPrive();

import { addNumber } from "../components/addNumber";
addNumber();

import { tabWithOutNewData, boostedEvenement } from "../components/editEvenementJs";
tabWithOutNewData();
boostedEvenement();

import { participationsAjaxShow } from '../components/participationsAjaxShow';
participationsAjaxShow();

import { materielAjax } from '../components/materielAjax';
materielAjax();

import { switchPeriod } from '../components/statistique';
switchPeriod();
