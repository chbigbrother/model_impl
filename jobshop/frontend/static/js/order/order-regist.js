function orderRegistFuncs(){
    const today = moment();
    // 검색 날짜 init
    flatpickr("#orddate, #estdate", {
        locale: Flatpickr.l10ns.ko,
        enableTime: false,
        dateFormat: "Y-m-d",
        disableMobile: true,
        defaultDate: [today.format('YYYY-MM-DD')]
    });

    /* $(".dropdown-btn").css('display', 'none'); */

    // csv 업로드
    var _url = "{% url 'order:order.order_read_csv' %}";
    var formData = new FormData();


    // 수주 개별 업로드 버튼
    $('.modal-upload-btn').on('click', function(){
        $('#uploadModal').modal({backdrop: 'static', keyboard: false})
        $("#uploadModal").modal("show");
    });
    // .csv 업로드 버튼
    $('.upload-btn').on('click', function(){
        $('#excelUploadModal').modal({backdrop: 'static', keyboard: false})
        $("#excelUploadModal").modal("show");
    });

    // 제품명 select box 그리기
    prodDraw();

    // 제품명 조회
    var result_data;
    function prodSearch() {
        $.ajax({
            url:  "/order/list/product/", /*"{% url 'order:order.product_lists' %}", */
            method: 'GET',
            dataType: 'json',
            async: false,
            contentType: 'application/json',
            processData: false,
            success: function(result) {
                result_data = result;
                console.log(result_data);
            }

        });
        return result_data;
    }
    // 제품명 select box 그리기
    function prodDraw() {
        $('#prodname_old').html('');
        var result = prodSearch();
        if (result.length > 1) {
            var innerHTML = '<select class="form-control" name="select" multiple="multiple" id="selectProduct">';
            for (var i = 0; i < result.length; i++) {
                if (typeof result[i] !== 'undefined') {
                    innerHTML += '<option class="ms-select ' + result[i].prod_id + '" value="' + result[i].prod_name + '">' + result[i].prod_name + ' </option>';
                }
            }
        } else {
            var innerHTML = '<input type="text" class="form-control" placeholder="해당일에 주문데이터가 없습니다." value="" readonly="readonly" />';
        }
        $('#prodname_old').html(innerHTML);
        $("#selectProduct").multipleSelect({
            filter: true
        });
        return;
    }

    function clickBodyEvent(event) {
        var target = event.target.className;
        if(target != "ms-choice" && target != "" && target != "placeholder" && $("#selectProduct").val().length > 0){
            var selected_ord = $('#prodname_old').find(':selected');
            if (selected_ord.length > 1) {
                $('#orderSelectDiv').css('overflow', 'scroll');
                $('#orderSelectDiv').css('overflow-x', 'hidden');
                $('#orderSelectDiv').css('height', '398px');
            }
            var innerHTML = '';
            for (var i = 0; i < selected_ord.length; i++) {
                if (typeof selected_ord[i].value != 'undefined') {
                    innerHTML += '<div class="col-xl-13" id="accordion">'+
                                '<div class="accordion accordion-header-bg accordion-bordered" id="accordion">'+
                                    '<div class="accordion-item">'+
                                        '<div class="accordion-header rounded-lg product_select" id="collapse-' + i + '" data-bs-toggle="collapse" data-bs-target="#collapse' + i + '" aria-controls="collapse' + i + '"   aria-expanded="true"  role="button">'+
                                            '<span class="accordion-header-icon"></span>'+
                                            '<span class="accordion-header-text" id="' + selected_ord[i].value + '">' + selected_ord[i].innerText + '</span>'+
                                            '<span class="accordion-header-indicator"></span>'+
                                        '</div>';
                                        innerHTML += '<div id="collapse' + i + '" class="collapse accordion__body show" aria-labelledby="accord-7One" data-bs-parent="#accordion">';
                               innerHTML += '<div class="accordion-body-text">'+
                                                '<label class="" style="margin-right:2.2rem;">요청기한</label>'+
                                                '<input class="col-md-6 form-control text-center estDate" type="text" name="dateFrom"/>'+
                                            '</div>'+
                                            '<div class="accordion-body-text">'+
                                                '<label class="" style="margin-right:2.2rem;">요구량(yd)</label>'+
                                                '<input class="col-md-6 form-control text-center demands" type="text" name="demands"/>'+
                                            '</div>'+
                                        '</div>'+
                                    '</div>'+
                                '</div>'+
                            '</div>';
                }
            }
            $('#prodname_old').html(innerHTML);
            // 검색 날짜 init
            flatpickr(".estDate", {
                locale: Flatpickr.l10ns.ko,
                enableTime: false,
                dateFormat: "Y-m-d",
                disableMobile: true,
                defaultDate: [today.format('YYYY-MM-DD')]
            });
            $('#prodname_old').attr('id', 'prodname');
            $('.col-lg-7').attr('class', '');
        }
    }

    $('#prodname_old').on('click', function(event) {

        var modalHTML = '';
            modalHTML += '<div class="modal modal-blur fade" id="modal-report" tabindex="-1" role="dialog" aria-hidden="true">'+
                          '<div class="modal-dialog modal-lg modal-dialog-centered" role="document">'+
                            '<div class="modal-content">'+
                              '<div class="modal-header">'+
                                '<h5 class="modal-title">제품 선택</h5>'+
                                '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'+
                              '</div>'+
                              '<div class="modal-body">'+
                                '<div class="mb-3">'+
                                  '<label class="form-label">제품명</label>'+
                                  '<div class="col-lg-7" id="prodname_old"> </div>'+
                                '</div>'+
                              '</div>'+
                              '<div class="modal-footer">'+
                                '<a href="#" class="btn btn-link link-secondary" data-bs-dismiss="modal">'+
                                  '취소'+
                                '</a>'+
                                '<a href="#" class="btn btn-primary ms-auto" data-bs-dismiss="modal">'+
                                  '<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>'+
                                  '저장'+
                                '</a>'+
                              '</div>'+
                            '</div>'+
                          '</div>'+
                        '</div>';
        var body = document.querySelector("body");
        body.addEventListener('click', clickBodyEvent);
    });

    /* **********************
       수주개별업로드 수주문서업로드 버튼 클릭 이벤트
     ********************** */
    $("#modal-upload").on("click", function(){
        var sch_date = $('#orddate').val();
        var pass = 'yes';
        var arr = new Array();
        var demands_arr = new Array();
        var product_arr = new Array();
        $('.estDate').each(function(i, elem){
            arr.push($(this).val());
        });
        $('.demands').each(function(i, elem){
            validation($(this).val());
            demands_arr.push($(this).val());
        });
        $('.accordion-header-text').each(function(i){
            product_arr.push($('.accordion-header-text')[i].id);
        });
        /* **********************
           마감기한 체크
         ********************** */
        for(var i=0; i<arr.length; i++){
            var exp_date = arr[i];
            if (exp_date < sch_date || exp_date == sch_date){
                pass = 'no';
                Swal.fire({
                  icon: 'error',
                  title: '마감기한 날짜 조정이 필요합니다.',
                  showCancelButton: true,
                  text: '마감기한은 주문일자보다 커야 합니다.'
                }).then(function(){

                });
            }
            break;
        }
        if (pass == 'yes'){
            var $request;
            var obj = new Object();
            obj.cust_name = $('#custname').val();
            obj.sch_date = $('#orddate').val();
            obj.exp_date = arr;
            obj.demands = demands_arr;
            obj.prod_name = product_arr;
            obj.amount = $('#demand').val();
            obj.contact = $('#phonenum').val();
            obj.email = $('#email').val();
            $.ajax({
                url: "/order/modal/create/",
                data : JSON.stringify(obj),
                type:'json',
                contentType: 'application/json',
                method: "POST",
                beforeSend: function(xhr, opts){
                    validation($('#custname').val())=='error'?xhr.abort():'';
                    validation($('#email').val())=='error'?xhr.abort():'';
                    validation($('#phonenum').val())=='error'?xhr.abort():'';
                },
                success: function(data){
                    console.log(data);
                    $('#modal-upload').remove();
                    $('.next-step').css('display', 'block');
                    // $(location).attr('href', "{% url 'order:order.order_list_view' %}")
                }
            });
        }
    });

    /* **********************
       유효성 검사
     ********************** */
    function validation(check){
        if(typeof check == 'undefined' || check.length <= 0){
            Swal.fire({
              icon: 'error',
              title: '필수 항목을 체크해 주세요.',
              showCancelButton: true,
              text: '필수 항목을 모두 입력해야 합니다.'
            }).then(function(){

            });
            return 'error';
        } else {
            return 'success';
        }
    }

    $("#fileReadBtn").on("click", function(e){
        $.ajax({
            url: _url,
            method:'POST',
            contentType: false,
            processData: false,
            data: formData,
            success: function(result){
                $(".dropdown-btn").css('display', 'block');
                $(".upload-btn").css('display', 'none');
                var innerHTML;
                var count = 0;
                for(var i=0; i<result.length; i++){
                    count = count + 1;
                    innerHTML += '<tr>' +
                        '<td>' + count + '</td>' +
                        '<td><input name="cust_name" value="' + result[i].cust_name + '"/></td>' +
                        '<td><input name="sch_date" value="' + result[i].sch_date + '"/></td>' +
                        '<td><input name="exp_date" value="' + result[i].exp_date + '"/></td>' +
                        '<td><input name="prod_name" value="' + result[i].prod_name + '"/></td>' +
                        '<td><input name="amount" value="' + result[i].amount + '"/></td>' +
                        '<td><input name="contact" value="' + result[i].contact + '"/></td>' +
                        '<td><input name="email" value="' + result[i].email + '"/></td>' +
                        '<td style="text-align:center;">' +
                            '<a href="#" id="delete_'+ count +'" onclick="deletedOrder(\'' + result[i].cust_name + '\',\'' + result[i].amount + '\')"><i class="fas fa-trash-alt"></i></a>' +
                        '</td>' +
                    '</tr>';
                }
                $('.tbody-data').html(innerHTML);
                if(result.message == 'error'){
                    Swal.fire({
                      icon: 'error',
                      title: '파일 형식 오류',
                      text: '데이터 항목을 형식에 맞춘 후 업로드 해 주세요.',
                      footer: '<a href="">형식 다운로드</a>'
                    });
                    return false;
                } else {
                    $('#excelUploadModal').modal('hide');
                }
            },
            error: function(error){
                console.log(error);
                // $('#css-loader').removeClass("is-active");
            }
        });
    });
    $('.btn-success-csv').on('click', function(){
        $('#excelUploadModal').modal('show');
    });
    /* $('#form').attr('action',"{% url 'order:order.csvCreate' %}").submit(); */
};

function deletedOrder(name, amount){
    var selectdata = new Object();
    selectdata.name = name;
    selectdata.amount = amount;
    selectdata.fileName = fileName;
    Swal.fire({
      icon: 'error',
      title: '삭제하시겠습니까?',
      showCancelButton: true,
      text: ''
    }).then(function(){
        $.ajax({
            url: "{% url 'order:order.order_delete_read_csv' %}",
            data : JSON.stringify(selectdata),
            type:'json',
            contentType: 'application/json',
            method: "POST",
            success: function(data){
                $('.tbody-data').html('');
                $(".dropdown-btn").css('display', 'block');
                var innerHTML;
                var count = 0;
                for(var i=0; i<data.length; i++){
                    count = count + 1;
                    innerHTML += '<tr>' +
                        '<td>' + count + '</td>' +
                        '<td><input name="cust_name" value="' + data[i].cust_name + '"/></td>' +
                        '<td><input name="sch_date" value="' + data[i].sch_date + '"/></td>' +
                        '<td><input name="exp_date" value="' + data[i].exp_date + '"/></td>' +
                        '<td><input name="prod_name" value="' + data[i].prod_name + '"/></td>' +
                        '<td><input name="amount" value="' + data[i].amount + '"/></td>' +
                        '<td><input name="contact" value="' + data[i].contact + '"/></td>' +
                        '<td><input name="email" value="' + data[i].email + '"/></td>' +
                        '<td style="text-align:center;">' +
                            '<a href="#" id="delete_'+ count +'" onclick="deletedOrder(\'' + data[i].cust_name + '\',\'' + data[i].amount + '\')"><i class="fas fa-trash-alt"></i></a>' +
                        '</td>' +
                    '</tr>';
                }
                $('.tbody-data').html(innerHTML);
            },
            error: function(error){
                console.log(error)
            }
        });
    });
    return false;
}

function progressSteps(current){
	var currentGfgStep, nextGfgStep, previousGfgStep;
	var opacity;
	var steps = $("fieldset").length;


	setProgressBar(current);

	$(".next-step").click(function () {

		currentGfgStep = $('fieldset').eq(current-1); /* $(this).parent(); */
		nextGfgStep = $('fieldset').eq(current-1).next(); /* $(this).parent().next(); */
        $("#progressbar li").eq(current).addClass("active");
        $("#progressbar li").eq(current-1).removeClass("active");

		nextGfgStep.show();
		currentGfgStep.animate({ opacity: 0 }, {
			step: function (now) {
				opacity = 1 - now;

				currentGfgStep.css({
					'display': 'none',
					'position': 'relative'
				});
				nextGfgStep.css({ 'opacity': opacity });
			},
			duration: 500
		});
		setProgressBar(++current);
	});

	$(".previous-step").click(function () {

		currentGfgStep = $(this).parent();
		previousGfgStep = $(this).parent().prev();

		$("#progressbar li").eq($("fieldset")
			.index(currentGfgStep)).removeClass("active");

		$("#progressbar li").eq(current).removeClass("active");
        $("#progressbar li").eq(current-2).addClass("active");

		previousGfgStep.show();

		currentGfgStep.animate({ opacity: 0 }, {
			step: function (now) {
				opacity = 1 - now;

				currentGfgStep.css({
					'display': 'none',
					'position': 'relative'
				});
				previousGfgStep.css({ 'opacity': opacity });
			},
			duration: 500
		});
		setProgressBar(--current);
	});

	function setProgressBar(currentStep) {
		var percent = parseFloat(100 / steps) * current;
		percent = percent.toFixed();

		$(".progress-bar")
			.css("width", percent + "%")
		$("#form fieldset").eq(currentStep-1).css("display", "block");
	}

	$(".submit").click(function () {
		return false;
	})
}

function drawScreen() {
    var innerHTML = '';
    innerHTML += '<ul id="progressbar">';
    var step;
    var name;
    $.ajax({
        url: "/order/status/",
        method:'GET',
        async: false,
        contentType: false,
        processData: false,
        success: function(result){
            name = result['user_name'];

            if(typeof(step) == "undefined"){
                step = 1;
            } else {
                step = result['status'];
            }
        }
    });
    for (var i=1; i<5; i++){
        if (i==step){
            innerHTML += '<li class="active" id="step'+ i + '">'+
                            '<strong>Step ' + i + '</strong>'+
                         '</li>';
        } else{
            innerHTML += '<li id="step'+ i + '"><strong>Step ' + i + '</strong></li>';
        }
    }
    var locations = "{{order_list}}";

    innerHTML+= '</ul>'+
                '<br>'+
                '<fieldset>'+
                    '<h2>주문 등록</h2>'+
                    '<div class="row mb-3">'+
                        '<div class="col-xl-6">'+
                            '<div class="mb-4">'+
                                '<label class="form-label">고객명</label>'+
                                '<input class="form-control text-center solid" readonly="readonly" type="text" name="custname" id="custname" value="' + name + '"/>'+
                            '</div>'+
                        '</div>'+
                        '<div class="col-xl-6">'+
                            '<div class="mb-4">'+
                                '<label class="form-label">주문일자</label>'+
                                '<input class="form-control text-center solid" type="text" name="orddate" id="orddate" readonly="readonly" />'+
                            '</div>'+
                        '</div>'+
                        '<div class="col-xl-6">'+
                            '<div class="mb-4">'+
                                '<label class="form-label">총 희망 가격</label>'+
                                '<input class="form-control text-center" type="text" name="cost" id="cost" />'+
                            '</div>'+
                        '</div>'+
                        '<div class="col-xl-6">'+
                            '<div class="mb-4">'+
                                '<label class="form-label">연락처</label>'+
                                '<input class="form-control text-center" type="text" name="dateFrom" id="phonenum" />'+
                            '</div>'+
                        '</div>'+
                        '<div class="col-xl-6">'+
                            '<div class="mb-4">'+
                                '<label class="form-label">이메일</label>'+
                                '<input class="form-control text-center" type="text" name="dateFrom" id="email" />'+
                            '</div>'+
                        '</div>'+
                        '<div class="col-xl-6">'+
                            '<div class="mb-4">'+
                                '<label class="form-label product_name">제품명</label>'+
                                '<div class="col-lg-7" id="prodname_old">'+
                                '</div>'+
                           '</div>'+
                        '</div>'+
                    '</div>'+
                    '<div class="col-6 col-sm-4 col-md-2 col-xl mb-3">'+
                        '<a href="#" class="btn btn-dark w-100" id="modal-upload">'+
                        '주문업로드'+
                        '</a>'+
                    '</div>'+
                    '<input type="button" name="next-step" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm next-step first-next-btn" value="다음"/>'+
                '</fieldset>'+
                '<fieldset>'+
                    '<div class="col-12">'+
                        '<div class="card">'+
                            '<div class="card-header">'+
                                '<h4 class="card-title">주문확인</h4>'+
                            '</div>'+
                            '<div class="card-body">'+
                               '<table id="example" class="display table table-vcenter card-table" style="min-width: 100%;">'+
                                    '<thead>'+
                                    '<tr>'+
                                        '<th style="width:10%;">번호</th>'+
                                        '<th style="width:10%;">고객명</th>'+
                                        '<th style="width:10%;">제품명</th>'+
                                        '<th style="width:10%;">요구량(yd)</th>'+
                                        '<th style="width:10%;">요청기한</th>'+
                                        '<th style="width:10%;">주문일자</th>'+
                                        '<th style="width:10%;">연락처(Phone)</th>'+
                                        '<th style="width:10%;">이메일</th>'+
                                        '<th style="width:10%;">관리</th>'+
                                    '</tr>'+
                                    '</thead>'+
                                    '<tbody class="order-tbody">'+
//                                        '{% for order in order_list %}'+
//                                        '<tr>'+
//                                            '<td class="idx">{{forloop.counter}}</td>'+
//                                            '<td class="cust_name">{{order.cust_name}}</td>'+
//                                            '<td class="prod_name">{{order.prod_id}}</td>'+
//                                            '<td class="amount">{{order.amount}}</td>'+
//                                            '<td class="exp_date">{{order.exp_date}}</td>'+
//                                            '<td class="sch_date">{{order.sch_date}}</td>'+
//                                            '<td class="contact">{{order.contact}}</td>'+
//                                            '<td class="email">{{order.email}}</td>'+
//                                        '</tr>'+
//                                        '{% endfor %}'+
                                    '</tbody>'+
                                '</table>'+
                            '</div>'+
                        '</div>'+
                    '</div>'+
                    '<input type="button" name="next-step" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm next-step" value="다음"/>'+
                    '<input type="button" name="previous-step" class="previous-step btn btn-secondary active w-100 " value="이전" />'+
                '</fieldset>'+
                '<fieldset>'+
                    '<img src="/static/icons/cargo.svg" width="400" height="auto" alt="Tabler"><h2></h2>'+
                    '<input type="button" name="next-step" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm next-step" value="다음"/>'+
                    '<input type="button" name="previous-step" class="previous-step btn btn-secondary active w-100 " value="이전" />'+
                '</fieldset>'+
                '<fieldset>'+
                    '<div class="finish">'+
                        '<h2 class="text text-center">'+
                            '<strong>FINISHED</strong>'+
                        '</h2>'+
                    '</div>'+
                    '<input type="button" name="previous-step" class="previous-step btn btn-secondary active w-100 " value="이전" />'+
                '</fieldset>';
    $('#form').html(innerHTML);
    progressSteps(step);

    $(".first-next-btn").click(function(){
        $.ajax({
            url: "/order/registered/list/",
            method: "GET",
            contentType: 'application/json',
            processData: false,
            success: function(data){
                var innerHTML = "";
                for(var i=0;i<data.length;i++){
                    innerHTML += '<tr>'+
                                    '<td class="idx">' + (i+1) + '</td>'+
                                    '<td class="cust_name">' + data[i].cust_name + '</td>'+
                                    '<td class="prod_name">' + data[i].prod_id + '</td>'+
                                    '<td class="amount">' + data[i].amount + '</td>'+
                                    '<td class="exp_date">' + data[i].exp_date + '</td>'+
                                    '<td class="sch_date">' + data[i].sch_date + '</td>'+
                                    '<td class="contact">' + data[i].contact + '</td>'+
                                    '<td class="email">' + data[i].email + '</td>'+
                                    '<td class=""><div class="action-buttons">'+
                                        '<a href="#" class="btn btn-warning light mr-2 rateComp" id="edit_' + data[i].prod_id.prod_name + '">'+
                                            '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18px" height="18px" viewBox="0 0 24 24" version="1.1" class="svg-main-icon">'+
                                                '<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">'+
                                                    '<rect x="0" y="0" width="24" height="24"></rect>'+
                                                    '<path d="M8,17.9148182 L8,5.96685884 C8,5.56391781 8.16211443,5.17792052 8.44982609,4.89581508 L10.965708,2.42895648 C11.5426798,1.86322723 12.4640974,1.85620921 13.0496196,2.41308426 L15.5337377,4.77566479 C15.8314604,5.0588212 16,5.45170806 16,5.86258077 L16,17.9148182 C16,18.7432453 15.3284271,19.4148182 14.5,19.4148182 L9.5,19.4148182 C8.67157288,19.4148182 8,18.7432453 8,17.9148182 Z" fill="#000000" fill-rule="nonzero" transform="translate(12.000000, 10.707409) rotate(-135.000000) translate(-12.000000, -10.707409) "></path>'+
                                                    '<rect fill="#000000" opacity="0.3" x="5" y="20" width="15" height="2" rx="1"></rect>'+
                                                '</g>'+
                                            '</svg>'+
                                        '</a>'+
                                        '<a href="#" class="btn btn-danger light deleteBtn">'+
                                            '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="20px" height="20px" viewBox="0 0 24 24" version="1.1" class="svg-main-icon">'+
                                                '<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">'+
                                                    '<rect x="0" y="0" width="24" height="24"></rect>'+
                                                    '<path d="M6,8 L6,20.5 C6,21.3284271 6.67157288,22 7.5,22 L16.5,22 C17.3284271,22 18,21.3284271 18,20.5 L18,8 L6,8 Z" fill="#000000" fill-rule="nonzero"></path>'+
                                                    '<path d="M14,4.5 L14,4 C14,3.44771525 13.5522847,3 13,3 L11,3 C10.4477153,3 10,3.44771525 10,4 L10,4.5 L5.5,4.5 C5.22385763,4.5 5,4.72385763 5,5 L5,5.5 C5,5.77614237 5.22385763,6 5.5,6 L18.5,6 C18.7761424,6 19,5.77614237 19,5.5 L19,5 C19,4.72385763 18.7761424,4.5 18.5,4.5 L14,4.5 Z" fill="#000000" opacity="0.3"></path>'+
                                                '</g>'+
                                            '</svg>'+
                                        '</a>'+
                                    '</div></td>'+
                                '</tr>';
                }

                $(".order-tbody").html(innerHTML);
            }
        });
    });
}

