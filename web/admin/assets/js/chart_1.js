/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$.ajax({
    type: 'GET',
    url: '../getTotalFeeByMonth',
    dataType: 'json',
    success: function (response) {
        var dataLists = response.datas;

        const ctx = document.getElementById('myChart');

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                        label: 'Revenue',
                        data: dataLists,
                        borderWidth: 1
                    }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    },
    error: function (jqXHR, textStatus, errorThrown) {
        console.error('Error:', textStatus, errorThrown);
    }
});

//const ctx_1 = document.getElementById('myChart_2');
//
//new Chart(ctx_1, {
//    type: 'doughnut',
//    data: {
//        labels: ['Emergency', 'Boarding', 'Nutrition', 'Grooming', 'Surgery'],
//        datasets: [{
//                label: 'Revenue',
//                data: [35, 10, 27, 4, 3],
//                borderWidth: 1
//            }]
//    },
//    options: {
//        scales: {
//            y: {
//                beginAtZero: true
//            }
//        }
//    }
//});


$.ajax({
    type: 'GET',
    url: '../get5ServicesUsedMost',
    dataType: 'json',
    success: function (response) {


        const ctx_1 = document.getElementById('myChart_2');
        new Chart(ctx_1, {
            type: 'pie',
            data: {
                labels: ['Very Satisfied', 'Satisfied', 'Unsatisfied'],
                datasets: [{
                        label: '%',
                        data: [response.VerySatisfied, response.Satisfied, response.Unsatisfied],
                        backgroundColor: [
                            'rgb(46, 213, 139)', // Color for 'Very Satisfied'
                            'rgb(255, 205, 86)', // Color for 'Satisfied'
                            'rgb(237, 111, 96)'   // Color for 'Unsatisfied'
                        ],
                    }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    },
    error: function (jqXHR, textStatus, errorThrown) {
        console.error('Error:', textStatus, errorThrown);
    }
});




$.ajax({
    type: 'GET',
    url: '../getWeeklySalePerWeek',
    dataType: 'json',
    success: function (response) {
        var dataLists = response.dataFee;
        var dataLists_1 = response.dataService;
        var dataLists_2 = response.dataLabel;
        const ctx_2 = document.getElementById('myChart_3');

        new Chart(ctx_2, {
            type: 'bar',
            data: {
                labels: dataLists_2,
                datasets: [{
                        type: 'bar',
                        label: 'Weekly Income in $',
                        data: dataLists,
                        backgroundColor: [
                            'rgba(34, 167, 240, 0.5)',
                            'rgba(99, 191, 240, 0.5)',
                            'rgba(167, 213, 237, 0.5)',
                            'rgba(226, 226, 226, 0.5)',
                            'rgba(225, 166, 146, 0.5)',
                            'rgba(222, 110, 86, 0.5)',
                            'rgba(225, 75, 49, 0.5)'
                        ],
                        borderColor: [
                            'rgba(34, 167, 240, 1.2)',
                            'rgba(99, 191, 240, 1.2)',
                            'rgba(167, 213, 237, 1.2)',
                            'rgba(226, 226, 226, 1.2)',
                            'rgba(225, 166, 146, 1.2)',
                            'rgba(222, 110, 86, 1.2)',
                            'rgba(225, 75, 49, 1.2)'
                        ],
                        borderWidth: 1.2,
                        yAxisID: 'y',
                        order: 2
                    },
                    {
                        type: 'line',
                        label: 'Weekly Services in Quantity',
                        data: dataLists_1,
                        backgroundColor: [
                            'rgba(0, 0, 0, 0.5)'
                        ],
                        borderColor: [
                            'rgba(0, 0, 0, 1)'
                        ],
                        borderWidth: 0.3,
                        yAxisID: 'quantity',
                        order: 1

                    }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        type: 'linear',
                        position: 'left',
                        grid: {
                            display: false
                        }
                    },
                    quantity: {
                        beginAtZero: true,
                        type: 'linear',
                        position: 'right',
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    },
    error: function (jqXHR, textStatus, errorThrown) {
        console.error('Error:', textStatus, errorThrown);
    }
});
