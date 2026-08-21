import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  static String id = 'AnalyticPage';

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int _selectedMetric = 0;
  int _selectedRange = 0;

  final List<String> _metricLabels = ['Calories', 'Duration', 'Weight'];
  final List<List<double>> _chartValues = [
    [420, 680, 510, 760, 590, 840, 720],
    [32, 48, 40, 56, 38, 62, 50],
    [78.4, 77.9, 78.1, 77.6, 77.4, 77.2, 77.0],
  ];

  String get _unit => _selectedMetric == 0 ? 'kcal' : _selectedMetric == 1 ? 'min' : 'kg';
  String get _average => _selectedMetric == 0 ? '646' : _selectedMetric == 1 ? '47' : '77.7';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FaIcon(FontAwesomeIcons.chartLine, size: 32, color: kAccentColor),
          const SizedBox(width: 8),
          const Text('Analytics', style: TextStyle(color: kLightAccentColor, fontSize: 18)),
        ]),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(color: kAccentColor, height: 1)),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildMetricSelector(),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _buildSummaryCard('Weekly average', '$_average $_unit', Icons.insights)),
            const SizedBox(width: 12),
            Expanded(child: _buildSummaryCard('Active days', '6 / 7', Icons.local_fire_department)),
          ]),
          const SizedBox(height: 18),
          _buildChartCard(),
          const SizedBox(height: 18),
          const Text('Recent activity', style: TextStyle(color: kLightAccentColor, fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildActivityTile('Upper body strength', 'Today, 8:40 AM', '680 kcal', Icons.fitness_center),
          _buildActivityTile('Treadmill intervals', 'Yesterday, 6:15 PM', '420 kcal', Icons.directions_run),
          _buildActivityTile('Mobility and core', 'Monday, 7:05 AM', '310 kcal', Icons.self_improvement),
        ]),
      ),
    );
  }

  Widget _buildMetricSelector() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: kSecondaryColor, borderRadius: BorderRadius.circular(16)),
      child: Row(children: List.generate(_metricLabels.length, (index) {
        final selected = _selectedMetric == index;
        return Expanded(child: GestureDetector(
          onTap: () => setState(() => _selectedMetric = index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(color: selected ? kAccentColor : Colors.transparent, borderRadius: BorderRadius.circular(12)),
            child: Text(_metricLabels[index], textAlign: TextAlign.center, style: TextStyle(color: selected ? kBackgroundColor : kLightAccentColor, fontWeight: FontWeight.w600)),
          ),
        ));
      })),
    );
  }

  Widget _buildSummaryCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: kSecondaryColor, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: kAccentColor, size: 21),
        const SizedBox(height: 14),
        Text(value, style: const TextStyle(color: kLightAccentColor, fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
      ]),
    );
  }

  Widget _buildChartCard() {
    final values = _chartValues[_selectedMetric];
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 12),
      decoration: BoxDecoration(color: kSecondaryColor, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${_metricLabels[_selectedMetric]} recap', style: const TextStyle(color: kLightAccentColor, fontSize: 16, fontWeight: FontWeight.bold)),
          DropdownButtonHideUnderline(child: DropdownButton<int>(
            value: _selectedRange,
            dropdownColor: kSecondaryColor,
            icon: const Icon(Icons.keyboard_arrow_down, color: kAccentColor, size: 18),
            style: const TextStyle(color: kLightAccentColor, fontSize: 13),
            items: const [DropdownMenuItem(value: 0, child: Text('This week')), DropdownMenuItem(value: 1, child: Text('Last week'))],
            onChanged: (value) => setState(() => _selectedRange = value ?? 0),
          )),
        ]),
        const SizedBox(height: 20),
        SizedBox(height: 205, child: BarChart(BarChartData(
          maxY: _selectedMetric == 2 ? 85 : null,
          minY: _selectedMetric == 2 ? 70 : 0,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: _selectedMetric == 2 ? 5 : 200, getDrawingHorizontalLine: (_) => FlLine(color: Colors.white10, strokeWidth: 1)),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) => SideTitleWidget(meta: meta, child: Text(['M', 'T', 'W', 'T', 'F', 'S', 'S'][value.toInt()], style: TextStyle(color: Colors.grey[500], fontSize: 11))))),
          ),
          barGroups: List.generate(values.length, (index) => BarChartGroupData(x: index, barRods: [BarChartRodData(toY: values[index], color: index == 5 ? kAccentColor : kAccentColor.withValues(alpha: 0.45), width: 15, borderRadius: BorderRadius.circular(4))])),
        ))),
      ]),
    );
  }

  Widget _buildActivityTile(String title, String date, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: kSecondaryColor, borderRadius: BorderRadius.circular(15)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: kAccentColor.withValues(alpha: 0.13), shape: BoxShape.circle), child: Icon(icon, color: kAccentColor, size: 19)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: kLightAccentColor, fontWeight: FontWeight.w600)), const SizedBox(height: 3), Text(date, style: TextStyle(color: Colors.grey[500], fontSize: 12))])),
        Text(value, style: const TextStyle(color: kAccentColor, fontWeight: FontWeight.bold, fontSize: 13)),
      ]),
    );
  }
}
