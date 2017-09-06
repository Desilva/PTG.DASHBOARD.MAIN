//reload when dropdown change
$("#Year").change(function () {
    $("#formCompanyHealth").submit()
})

$("#View").change(function () {
    $("#formCompanyHealth").submit()
})

function setGrid(data, summary) {
    $("#grid").kendoGrid({
        dataSource: getAccountDataSource(data),
        pageable: false,
        sortable: false,
        resizable: true,
        scrollable: true,
        columnMenu: true,
        columns: [
            {
                field: "RatioDesc",
                title: "Ratio",
                //locked: true,
                columnMenu: false,
                menu: false,
                width: "300px",
                footerTemplate: "<b>KLASIFIKASI TINGKAT KESEHATAN</b>"
            },
            {
                field: "ValueJan",
                title: " Jan",
                width: "100px",
                template: "<p class='text-right'>#=ValueJan#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueJan+"</p>",                
            },
            {
                field: "ValueFeb",
                title: " Feb",
                width: "100px",
                template: "<p class='text-right'>#=ValueFeb#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueFeb + "</p>",
            },
            {
                field: "ValueMar",
                title: " Mar",
                width: "100px",
                template: "<p class='text-right'>#=ValueMar#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueMar + "</p>",
            },
            {
                field: "ValueApr",
                title: " Apr",
                width: "100px",
                template: "<p class='text-right'>#=ValueApr#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueApr + "</p>",
            },
            {
                field: "ValueMei",
                title: " Mei",
                width: "100px",
                template: "<p class='text-right'>#=ValueMei#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueMei + "</p>",
            },
            {
                field: "ValueJun",
                title: " Jun",
                width: "100px",
                template: "<p class='text-right'>#=ValueJun#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueJun + "</p>",
            },
            {
                field: "ValueJul",
                title: " Jul",
                width: "100px",
                template: "<p class='text-right'>#=ValueJul#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueJul + "</p>",
            },
            {
                field: "ValueAug",
                title: " Aug",
                width: "100px",
                template: "<p class='text-right'>#=ValueAug#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueAug + "</p>",
            },
            {
                field: "ValueSep",
                title: " Sep",
                width: "100px",
                template: "<p class='text-right'>#=ValueSep#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueSep + "</p>",
            },
            {
                field: "ValueOkt",
                title: " Okt",
                width: "100px",
                template: "<p class='text-right'>#=ValueOkt#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueOkt + "</p>",
            },
            {
                field: "ValueNov",
                title: " Nov",
                width: "100px",
                template: "<p class='text-right'>#=ValueNov#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueNov + "</p>",
            },
            {
                field: "ValueDes",
                title: " Des",
                width: "100px",
                template: "<p class='text-right'>#=ValueDes#</p>",
                footerTemplate: "<p class='text-right'>" + summary.ValueDes + "</p>",
            },
            {
                field: "CompanyHealthCategoryDesc",
                title: "",
                columnMenu: false,
                menu: false,
                groupHeaderTemplate: "#= value.substring(1) #",
                hidden: true
            },
            {
                field: "CategoryDesc",
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
        group: [{
            field: "CompanyHealthCategoryDesc"
        }, {
            field: "CategoryDesc"
        }],
        sort:{
                field: "OrderNum", dir: "asc"
        },
    });

    return result;
}