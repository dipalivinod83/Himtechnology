
document.getElementById('predictBtn').addEventListener('click', function() {
const sales = parseFloat(document.getElementById('inputSales').value);
const customers = parseFloat(document.getElementById('inputCustomers').value);

if (!isNaN(sales) && !isNaN(customers)) {
// Dummy prediction logic
const predictedGrowth = (sales * 0.1) + (customers * 5);
const predictionResult = `Based on your input, your predicted growth for next month is: $${predictedGrowth.toFixed(2)}`;

document.getElementById('result').innerText = predictionResult;
} else {
document.getElementById('result').innerText = 'Please enter valid numbers for sales and customers.';
}
});

