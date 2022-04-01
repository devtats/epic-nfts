// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

// いくつかの OpenZeppelin のコントラクトをインポートします。
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// Base64.solコントラクトからSVGとJSONをBase64に変換する関数をインポートします。
import { Base64 } from "./libraries/Base64.sol";
// "is ERC721URIStorage" インポートした OpenZeppelin のコントラクトを継承
contract MyEpicNFT is ERC721URIStorage {
  // OpenZeppelin が tokenIds を簡単に追跡するために提供するライブラリを呼び出しています
  using Counters for Counters.Counter;

  // _tokenIdsを初期化（_tokenIds = 0）
  Counters.Counter private _tokenIds;

// すべてのNFTにSVGコードを適用するために、baseSvg変数を作成します。
  string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

  // 3つの配列 string[] に、それぞれランダムな単語を設定しましょう。
  string[] firstWords = ["YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD"];
  string[] secondWords = ["YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD"];
  string[] thirdWords = ["YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD", "YOUR_WORD"];

  // NFT トークンの名前とそのシンボルを渡します。
  constructor() ERC721 ("SquareNFT", "SQUARE") {
    console.log("This is my NFT contract.");
  }

  // シードを生成する関数を作成します。
  function random(string memory input) internal pure returns (uint256) {
    return uint256(keccak256(abi.encodePacked(input)));
  }

  // 一番目に表示される単語
  function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));

    console.log("rand seed: ", rand);

    rand = rand % firstWords.length;

    console.log("rand first word: ", rand);
    return firstWords[rand];
  }

  // 二番目に表示される単語
  function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));

    console.log("rand seed: ", rand);

    rand = rand % secondWords.length;

    console.log("rand first word: ", rand);
    return secondWords[rand];
  }

  // 三番目に表示される単語
  function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));

    console.log("rand seed: ", rand);

    rand = rand % thirdWords.length;

    console.log("rand first word: ", rand);
    return thirdWords[rand];
  }

  // ユーザーが NFT を取得するために実行する関数です。
  function makeAnEpicNFT() public {
     // 現在のtokenIdを取得します。tokenIdは0から始まります。
    uint256 newItemId = _tokenIds.current();

    // ３つの配列からそれぞれ一つの単語をランダムに取り出す
    string memory first = pickRandomFirstWord(newItemId); 
    string memory second = pickRandomSecondWord(newItemId); 
    string memory third = pickRandomThirdWord(newItemId); 

	  // 3つの単語を連携して格納する変数 combinedWord を定義します。
      string memory combinedWord = string(abi.encodePacked(first, second, third));

    // ３つの単語を連結して、<text>,<svg>で閉じる
    string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, third, "</text></svg>"));


    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");

  string memory json = Base64.encode(
    bytes(
      string(
        abi.encodePacked(
          '{"name": "',combinedWord,
          '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
          Base64.encode(bytes(finalSvg)),
          '"}'
        )
      )
    )
  );

  string memory finalTokenUri = string(
    abi.encodePacked("data:application/json;base64,", json)
  );

	  console.log("\n----- Token URI ----");
    console.log(finalTokenUri);
    console.log("--------------------\n");

    // msg.sender を使って NFT を送信者に Mint します。
    _safeMint(msg.sender, newItemId);

    // tokenURIを更新します。
    _setTokenURI(newItemId, finalTokenUri);

    // NFTがいつ誰に作成されたかを確認します。
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    // 次の NFT が Mint されるときのカウンターをインクリメントする。
    _tokenIds.increment();
  }
}