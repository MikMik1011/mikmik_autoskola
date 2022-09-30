// question variables
var questionNumber = 1;
var userAnswer = [];
var goodAnswer = [];
var questionUsed = [];
var nbQuestionToAnswer = 10; // don't forget to change the progress bar max value in html
var nbAnswerNeeded = 5; // out of nbQuestionToAnswer
var nbPossibleQuestions = tableauQuestion.length; // number of questions in database questions.js
var lastClick = 0;

function getRandomQuestion() {
	var random = Math.floor(Math.random() * nbPossibleQuestions);

	while (true) {
		if (questionUsed.indexOf(random) === -1) {
			break;
		}

		random = Math.floor(Math.random() * nbPossibleQuestions);
	}

	questionUsed.push(random);

	return random;
}

// Partial Functions
function closeMain() {
	$(".home").css("display", "none");
}
function openMain() {
	$(".home").css("display", "block");
}
function closeAll() {
	$(".body").css("display", "none");
}
function openQuestionnaire() {
	$(".questionnaire-container").css("display", "block");
	var randomQuestion = getRandomQuestion();

	

	$("#questionNumero").html(`Pitanje ${questionNumber}  / ${nbQuestionToAnswer} :`);
	$("#question").html(tableauQuestion[randomQuestion].question);
	
	
		
	/*if (!tableauQuestion[randomQuestion].slika) $('.pitanjeslika').hide();
	else {
		$('.pitanjeslika').attr('src', tableauQuestion[randomQuestion].slika);
		$('.pitanjeslika').show();
	}*/
	$(".answerA").html(tableauQuestion[randomQuestion].propositionA);
	$(".answerB").html(tableauQuestion[randomQuestion].propositionB);
	$(".answerC").html(tableauQuestion[randomQuestion].propositionC);
	$(".answerD").html(tableauQuestion[randomQuestion].propositionD);

	var odgovori = ["A", "B", "C", "D"]
	for(var target of odgovori) {
    	var target2 = odgovori[Math.floor(Math.random() * odgovori.length -1) +1];
		$(`.div${target}`).show();
    	if ($(`.answer${target}`).html() == "") $(`.div${target}`).hide();
		$(`.div${target}`).after($(`.div${target2}`));
	}

	$('input[name=question]').attr('checked', false);

	goodAnswer.push(tableauQuestion[randomQuestion].reponse);
	$(".questionnaire-container .progression").val(questionNumber - 1);
	//updateProgress(questionNumber - 1)
}
function openResultGood() {
	$(".resultGood").css("display", "block");
}

/*function updateProgress(value) {
	let duration = 1000;
	let jump = 0.01;
	let current = $(".questionnaire-container .progression").val();
	let move = value - current;
	let moveAmt = move / jump; 
	let moveDur = duration / moveAmt;
	var interval = setInterval(function() {
		$(".questionnaire-container .progression").val(current + jump);
		current = $(".questionnaire-container .progression").val();
		if (current = value) clearInterval(interval);
	}, moveDur); 
	
}*/

function openResultBad() {
	$(".resultBad").css("display", "block");
}
function openContainer() {
	$(".question-container").css("display", "block");
}
function closeContainer() {
	$(".question-container").css("display", "none");
}

// Listen for NUI Events
window.addEventListener('message', function (event) {
	var item = event.data;

	// Open & Close main window
	if (item.openQuestion == true) {
		openContainer();
		openMain();
	}

	if (item.openQuestion == false) {
		closeContainer();
		closeMain();
	}

	// Open sub-windows / partials
	if (item.openSection == "question") {
		closeAll();
		openQuestionnaire();
		
	}
});

// Handle Button Presses
$(".btnQuestion").click(function () {
	$.post('http://revolucija_autoskola/question', JSON.stringify({}));
});

$(".btnClose").click(function () {
	$.post('http://revolucija_autoskola/close', JSON.stringify({}));
	userAnswer = [];
	goodAnswer = [];
	questionUsed = [];
	questionNumber = 1;
});

$(".btnKick").click(function () {
	$.post('http://revolucija_autoskola/kick', JSON.stringify({}));
	userAnswer = [];
	goodAnswer = [];
	questionUsed = [];
	questionNumber = 1;
});

// Handle Form Submits
$("#question-form").submit(function (e) {
	e.preventDefault();

	if (questionNumber != nbQuestionToAnswer) {
		//question 1 to 9: pushing answer in array
		closeAll();
		userAnswer.push($('input[name="question"]:checked').val());
		questionNumber++;
		openQuestionnaire();
	} else {
		// question 10: comparing arrays and sending number of good answers
		userAnswer.push($('input[name="question"]:checked').val());
		var nbGoodAnswer = 0;
		for (i = 0; i < nbQuestionToAnswer; i++) {
			if (userAnswer[i] == goodAnswer[i]) {
				nbGoodAnswer++;
			}
		}

		closeAll();
		if (nbGoodAnswer >= nbAnswerNeeded) {
			openResultGood();
		} else {
			openResultBad();
		}
	}

	return false;
});
