//reload when dropdown change
$("#Year").change(function () {
    $("#formBS").submit()
})

function setGrid(data, editLink) {
    $("#grid").kendoGrid({
        dataSource: getAccountDataSource(data),
        pageable: false,
        sortable: false,
        resizable: true,
        scrollable: true,
        columnMenu: true,
        columns: [
            {
                field: "AccountName",
                title: "Akun",
                columnMenu: false,
                menu: false,
                width: "300px"
            },
            {
                field: "ValueJan",
                title: " Jan",
                template: "<p class='text-right'>#=ValueJan#</p>",
                headerTemplate: '<label for="check-all">Jan &nbsp;<span><a href=' + editLink[1] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueFeb",
                title: " Feb",
                template: "<p class='text-right'>#=ValueFeb#</p>",
                headerTemplate: '<label for="check-all">Feb &nbsp;<span><a href=' + editLink[2] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueMar",
                title: " Mar",
                template: "<p class='text-right'>#=ValueMar#</p>",
                headerTemplate: '<label for="check-all">Mar &nbsp;<span><a href=' + editLink[3] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueApr",
                title: " Apr",
                template: "<p class='text-right'>#=ValueApr#</p>",
                headerTemplate: '<label for="check-all">Apr &nbsp;<span><a href=' + editLink[4] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueMei",
                title: " Mei",
                template: "<p class='text-right'>#=ValueMei#</p>",
                headerTemplate: '<label for="check-all">Mei &nbsp;<span><a href=' + editLink[5] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueJun",
                title: " Jun",
                template: "<p class='text-right'>#=ValueJun#</p>",
                headerTemplate: '<label for="check-all">Jun &nbsp;<span><a href=' + editLink[6] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueJul",
                title: " Jul",
                template: "<p class='text-right'>#=ValueJul#</p>",
                headerTemplate: '<label for="check-all">Jul &nbsp;<span><a href=' + editLink[7] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueAug",
                title: " Aug",
                template: "<p class='text-right'>#=ValueAug#</p>",
                headerTemplate: '<label for="check-all">Agt &nbsp;<span><a href=' + editLink[8] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueSep",
                title: " Sep",
                template: "<p class='text-right'>#=ValueSep#</p>",
                headerTemplate: '<label for="check-all">Sep &nbsp;<span><a href=' + editLink[9] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueOkt",
                title: " Okt",
                template: "<p class='text-right'>#=ValueOkt#</p>",
                headerTemplate: '<label for="check-all">Okt &nbsp;<span><a href=' + editLink[10] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueNov",
                title: " Nov",
                template: "<p class='text-right'>#=ValueNov#</p>",
                headerTemplate: '<label for="check-all">Nov &nbsp;<span><a href=' + editLink[11] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "ValueDes",
                title: " Des",
                template: "<p class='text-right'>#=ValueDes#</p>",
                headerTemplate: '<label for="check-all">Des &nbsp;<span><a href=' + editLink[12] + '><i class="fa fa-edit" aria-hidden="true"></i></a></span></label>',
                width: "100px"
            },
            {
                field: "AccountCategoryDesc",
                title: "",
                columnMenu: false,
                menu: false,
                groupHeaderTemplate: "#= value.substring(1) #",
                hidden: true
            }
        ]
    });
}

function getAccountDataSource(data) {
    var result = new kendo.data.DataSource({
        pageable: false,
        serverFiltering: false,
        serverPaging: false,
        serverSorting: false,
        data: data,
        group: {
            field: "AccountCategoryDesc",
            dir: "asc"
        },
        sort: { field: "OrderNum", dir: "asc" },
    });

    return result;
}


var formDialog = $("#formWindow").kendoWindow({
    width: "400px",
    visible: false,
    resizable: false,
    modal: true,
    actions: [
        "Close"
    ],
    close: function (e) {
        $("#formWindow").html("");
        $("html, body").css("overflow", "");
    }
}).data("kendoWindow");

function setStyleFormWindow() {
    $(".k-window").removeClass("k-widget");
    $(".k-window-titlebar").css("height", "36px");
    $(".k-window-actions").find("a").css("height", "20px");
    $(".k-window-actions").find("a").css("width", "20px");
}

function setValidator() {
    $.validator.unobtrusive.parse("#balanceForm");
    $("#balanceForm").data("validator").settings.ignore = ":hidden:not(.validateAlways)";

    $("input").on("keyup blur", function () {
        if ($("#balanceForm").valid()) {
            $("button[type=submit]").prop("disabled", false);
        } else {
            $("button[type=submit]").prop("disabled", "disabled");
        }

        setTimeout(function () {
            if ($("input").hasClass("input-validation-error")) {
                $("button[type=submit]").prop("disabled", "disabled");
            }
        }, 100);
    });

    $("input[type=text], input[type=hidden]").each(function () {
        var req = $(this).attr("data-val-required");
        if (undefined !== req) {
            var label = $(this).parentsUntil("form").find("label[for='" + $(this).attr("id") + "']");
            var text = label.text();
            if (text.length > 0) {
                label.append("<span style='color:red'> *</span>");
            }
        }
    });

    $("#formWindow, input[type=text]").keypress(function (e) {
        if (e !== undefined) {
            var keycode = e.keyCode || e.which;

            switch (keycode) {
                case 13:
                    e.preventDefault();
                    $("#balanceForm").submit();
                    return false;
                case 27:
                    e.preventDefault();
                    closeWindow();
                    return false;
                default:
                    return true;
            }
        }
    });
}

function setFormUpload() {
    $("#balanceForm").submit(function (e) {
        $("#YearReference").val($("#Year").val());
        if ($("input").hasClass("input-validation-error")) {
            e.preventDefault();
            return false;
        } else {
            $.ajax({
                type: $(this).attr("method"),
                url: $(this).attr("action"),
                data: $(this).serialize(),
                success: function (data) {
                    console.log(data);
                    if (data.Success) {
                        //swal({
                        //    title: 'Sukses',
                        //    text: data.Message,
                        //    type: 'success'
                        //}, function () {
                        //    location.reload();
                        //});
                        submitFlag = true;
                        window.location.reload();
                        formDialog.close();
                        //ds.read();

                    }
                    else {
                        swal("Error", data.Message, "error");
                        submitFlag = true;
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    formDialog.close();
                    swal("Error", "Server Error. Harap hubungi administrator", "error");
                }
            });
            $(".sweet-alert").css("z-index", "999999");
            e.preventDefault();
            return false;
        }
    });
}

var inputFileSelector = "#FileExcel";

//FILE RELATED
function onRemove(e) {
    $(inputFileSelector).val("");
}

function onSelectFile(e) {
    var flagExtension = 0;
    var flagSize = 0;
    var allowedExtension;
    var file = e.files;
    allowedExtension = ['.xlsx'];
    if (file[0].size > 1048576) {
        flagSize = 1;
    }

    if ($.inArray((file[0].extension).toLowerCase(), allowedExtension) === -1) {
        flagExtension = 1;
    }

    if (flagExtension == 1) {
        alert("Jenis berkas harus .xlsx");
        e.preventDefault();
    }

    if (flagSize == 1) {
        alert("Ukuran Maksimal");
        e.preventDefault();
    }
}

function onSuccessFile(e) {
    var filepath = e.response.filepath;
    $(inputFileSelector).val(filepath);
    if (e.operation == "upload") {
        var file = e.response;
        $('#FileExcel').val(file.filepath);
        console.log($('#FileExcel').val());
        var ext = e.files[0].extension;

    }
}

function uploadExcel() {
    var url = "";
    var body = document.body,
        html = document.documentElement;
    var height = Math.max(body.scrollHeight, body.offsetHeight,
        html.clientHeight, html.scrollHeight, html.offsetHeight);

    console.log(height);
    kendo.ui.progress($("#formWindow"), true);
    url = urlAction("UpdateData", "BalanceSheet", "Upload");
    $(".k-window").css("margin-top", "-140px");
    $(".k-window").css("margin-left", "-10px");
    $("#formWindow").load(url, function (response, status, xhr) {
        $("#KendoUploader").kendoUpload({
            multiple: false,
            async: {
                saveUrl: urlAction("", "FileManagement", "Save"),
                removeUrl: urlAction("", "FileManagement", "Remove"),
                autoUpload: true
            },
            multiple: false,
            select: onSelectFile,
            success: onSuccessFile,
            remove: onRemove,
            showFileList: true,
        });
        setStyleFormWindow();
        setValidator();
        setFormUpload();
        kendo.ui.progress($("#formWindow"), false);
        $("html, body").css("overflow", "hidden");
        setTimeout(function () {
            $("#FileExcel").focus();
        }, 500);
    });

    formDialog.title("Upload Excel");
    formDialog.center();
    formDialog.open();
}

function closeWindow() {
    formDialog.close();
}

function downloadExcel() {
    var url = urlAction("UpdateData", "BalanceSheet", "Download");
    var year = $("#Year").val();
    window.location.href = url + "?Year=" + year;
}