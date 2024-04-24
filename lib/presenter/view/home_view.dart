import 'package:crypto_now/domain/entities/ticker.dart';
import 'package:crypto_now/presenter/viewmodel/home_viewmodel.dart';
import 'package:crypto_now/shared/components/base/base_view.dart';
import 'package:crypto_now/shared/functions/screen_size.dart';
import 'package:crypto_now/shared/resources/assets/assets.dart';
import 'package:crypto_now/shared/resources/theme/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(cryptoTickerNotifierProvider.notifier).loadTickers();
    final width = screenWidth(context);

    final listCryptos = ref.watch(cryptoTickerNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Row(
                children: [
                  Image.asset(
                    Assets.symbol,
                    height: 40,
                  ),
                  SizedBox(width: width / 18),
                  Text(
                    "Crypto",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BaseView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: listCryptos.isNotEmpty,
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                            aspectRatio: 1.7,
                            child: LineChart(
                              LineChartData(
                                // minY: -10.0,
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    show: true,
                                    isCurved: true,
                                    barWidth: 4,
                                    isStrokeJoinRound: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.red,
                                        Colors.red[600]!,
                                        Colors.purpleAccent,
                                        Colors.green,
                                        Colors.green[600]!,
                                      ],
                                    ),
                                    color: Colors.yellow[700],
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.red.withOpacity(0.1),
                                          Colors.red.withOpacity(0.3),
                                          Colors.purpleAccent.withOpacity(0.3),
                                          Colors.green.withOpacity(0.2),
                                          Colors.green.withOpacity(0.3),
                                        ],
                                      ),
                                    ),
                                    spots: List.generate(10, (index) {
                                      final crypto = listCryptos.isNotEmpty
                                          ? listCryptos[index]
                                          : Tickers();
                                      return FlSpot(
                                          index.toDouble(),
                                          double.tryParse(
                                                  crypto.priceChangePercent ?? '') ??
                                              0.0);
                                    }),
                                    dotData: const FlDotData(show: false),
                                  ),
                                ],

                                gridData: FlGridData(
                                  show: false,
                                  drawHorizontalLine: true,
                                  getDrawingHorizontalLine: (value) {
                                    return const FlLine(
                                      color: Colors.pinkAccent,
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, tile) {
                                          if (value.toInt() >= 0 &&
                                              value.toInt() < listCryptos.length) {
                                            return Text(
                                              "${listCryptos[value.toInt()].symbol}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(fontSize: 12),
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                    )),
                              ),

                              duration:
                                  const Duration(milliseconds: 150), // Optional
                              curve: Curves.linear,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 8),
                      child: Text(
                        "Watchlist Coin",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColor.greyLightLogo),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (listCryptos.isEmpty) {
                          return Container();
                        } else {
                          final crypto = listCryptos[index];
                          return Card(
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${crypto.symbol}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                              "${double.tryParse(crypto.priceChangePercent ?? '0.0')?.toStringAsFixed(2)}%",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: crypto.priceChangePercent!
                                                            .contains('+')
                                                        ? Colors.green[900]
                                                        : crypto.priceChangePercent!
                                                                .contains('-')
                                                            ? Colors.red[900]
                                                            : Colors.white,
                                                  )),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "\$ ${crypto.priceChange}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$ ${crypto.lastPrice}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.green),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text("Bid"),
                                          Row(
                                            children: [
                                              Text(
                                                "\$ ${double.parse(crypto.bidPrice ?? '0.0').toStringAsFixed(7)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      fontWeight: FontWeight.w300,
                                                    ),
                                              ),
                                              SizedBox(width: width / 18),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(double.parse(
                                                        crypto.bidQty ?? '0.0')
                                                    .toStringAsFixed(3)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: width / 18),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text("Ask"),
                                            Flexible(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(5),
                                                    ),
                                                    child: Text(double.parse(
                                                            crypto.askQty ?? '0.0')
                                                        .toStringAsFixed(3)),
                                                  ),
                                                  SizedBox(width: width / 18),
                                                  Flexible(
                                                    child: Text(
                                                      "\$ ${double.parse(crypto.askPrice ?? '0.0').toStringAsFixed(7)}",
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
