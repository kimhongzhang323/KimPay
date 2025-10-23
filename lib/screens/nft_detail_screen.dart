import 'package:flutter/material.dart';
import '../design_system/app_colors.dart';

class NftDetailScreen extends StatefulWidget {
  final String name;
  final String emoji;
  final String price;

  const NftDetailScreen({
    super.key,
    required this.name,
    required this.emoji,
    required this.price,
  });

  @override
  State<NftDetailScreen> createState() => _NftDetailScreenState();
}

class _NftDetailScreenState extends State<NftDetailScreen> {
  bool _isAiAnalyzing = false;
  String _aiRarity = '';
  String _aiPricePredict = '';
  String _aiAuthenticity = '';

  @override
  void initState() {
    super.initState();
    _performAiAnalysis();
  }

  void _performAiAnalysis() {
    setState(() {
      _isAiAnalyzing = true;
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      setState(() {
        _isAiAnalyzing = false;
        _aiRarity = _calculateRarity();
        _aiPricePredict = _predictPrice();
        _aiAuthenticity = _verifyAuthenticity();
      });
    });
  }

  String _calculateRarity() {
    if (widget.name.contains('Bored Ape')) {
      return 'Ultra Rare - Top 2% of collection. Unique trait combination detected: Golden Fur + Laser Eyes + Crown. Only 47 similar NFTs exist.';
    } else if (widget.name.contains('CryptoPunk')) {
      return 'Legendary - Top 0.5% of collection. This is an Alien type (9 total). Estimated rarity score: 9.8/10.';
    } else if (widget.name.contains('Azuki')) {
      return 'Rare - Top 8% of collection. Features rare Red Kimono and Spirit Fox. Community demand: High.';
    } else {
      return 'Uncommon - Top 15% of collection. Good trait distribution with potential for value appreciation.';
    }
  }

  String _predictPrice() {
    if (widget.name.contains('Bored Ape')) {
      return 'AI predicts 12-18% value increase in next 30 days based on floor price trends and whale wallet movements.';
    } else if (widget.name.contains('CryptoPunk')) {
      return 'Strong hold recommendation. Historical data shows 95% probability of maintaining value. Potential 25% upside in 90 days.';
    } else if (widget.name.contains('Azuki')) {
      return 'Moderate growth expected. Recent collection activity suggests 5-10% increase possible within 2 weeks.';
    } else {
      return 'Stable outlook. AI recommends monitoring for 7 days before making trading decisions.';
    }
  }

  String _verifyAuthenticity() {
    final hexString = widget.hashCode.toRadixString(16).padLeft(8, '0');
    final contractAddress = hexString.length >= 8 ? hexString.substring(0, 8) : hexString;
    return 'Verified on blockchain. Contract: 0x$contractAddress...\nMinted: ${DateTime.now().subtract(Duration(days: (widget.hashCode.abs() % 365))).toString().split(' ')[0]}\nOwnership: Clean chain of custody verified.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildNftPreview(),
                const SizedBox(height: 24),
                _buildPriceInfo(),
                const SizedBox(height: 24),
                _buildAiAnalysisCard(),
                const SizedBox(height: 24),
                _buildTraitsSection(),
                const SizedBox(height: 24),
                _buildProvenanceSection(),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 80,
      pinned: true,
      backgroundColor: AppColors.primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accentPurple,
                AppColors.primaryBlue,
              ],
            ),
          ),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildNftPreview() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentPurple.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accentPurple.withOpacity(0.2),
                AppColors.primaryBlue.withOpacity(0.2),
              ],
            ),
          ),
          child: Center(
            child: Text(
              widget.emoji,
              style: const TextStyle(fontSize: 180),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Price',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentPurple,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      size: 16,
                      color: AppColors.accentGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${(widget.hashCode % 20) + 5}%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPriceDetail('Floor Price', '${double.parse(widget.price.split(' ')[0]) * 0.8} ETH'),
              _buildPriceDetail('Last Sale', '${double.parse(widget.price.split(' ')[0]) * 0.95} ETH'),
              _buildPriceDetail('Owners', '${(widget.hashCode % 500) + 100}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAiAnalysisCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accentPurple.withOpacity(0.1),
            AppColors.primaryBlue.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accentPurple.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.accentPurple,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'AI NFT Analysis',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (_isAiAnalyzing)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentPurple),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          if (_isAiAnalyzing)
            Text(
              'AI is analyzing rarity traits, market trends, and blockchain data...',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnalysisSection('🎯 Rarity Analysis', _aiRarity),
                const SizedBox(height: 16),
                _buildAnalysisSection('📈 Price Prediction', _aiPricePredict),
                const SizedBox(height: 16),
                _buildAnalysisSection('✓ Authenticity Check', _aiAuthenticity),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.accentPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            height: 1.5,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTraitsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Traits',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildTraitChip('Background', 'Gold', '5%'),
              _buildTraitChip('Fur', 'Purple', '8%'),
              _buildTraitChip('Eyes', 'Laser', '2%'),
              _buildTraitChip('Mouth', 'Smile', '15%'),
              _buildTraitChip('Accessory', 'Crown', '3%'),
              _buildTraitChip('Clothes', 'Suit', '12%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTraitChip(String type, String value, String rarity) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$rarity rarity',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.accentPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvenanceSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Provenance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildProvenanceItem('Minted', '245 days ago', Icons.create),
          const SizedBox(height: 12),
          _buildProvenanceItem('Transfers', '3 total', Icons.swap_horiz),
          const SizedBox(height: 12),
          _buildProvenanceItem('Blockchain', 'Ethereum', Icons.link),
        ],
      ),
    );
  }

  Widget _buildProvenanceItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.accentPurple),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'List for Sale',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text('Transfer'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility),
                  label: const Text('View on OpenSea'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
