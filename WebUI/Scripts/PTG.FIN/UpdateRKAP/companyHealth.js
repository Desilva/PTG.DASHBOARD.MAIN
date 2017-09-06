//reload when dropdown change
$("#Year").change(function () {
    $("#formCompanyHealth").submit()
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
                field: "RatioDesc",
                title: "Ratio",
                //locked: true,
                columnMenu: false,
                menu:false,
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