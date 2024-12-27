// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.9;
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns(bytes4);
}
contract ERC721_Abhi_Patel {
    string public _name;
    string public _symbol;
    string private _message;
    uint256 public nextTokenIdToMint;
    address public contractOwner;
        mapping(uint256 => address) internal _owners;
        mapping(address => uint256) internal _balances;
        mapping(uint256 => address) internal _tokenApprovals;
        mapping(address => mapping(address => bool)) internal _operatorApprovals;
        mapping(uint256 => string) _tokenUris;
    event Transfer(address indexed _from, address indexed _to, uint256
    indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256
    indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator,
            bool _approved);
        constructor(string memory name, string memory symbol, string memory
    message) {
            _name = name;
            _symbol = symbol;
            _message = message;
            nextTokenIdToMint = 0;
            contractOwner = msg.sender;
        }
        function message() public view returns(string memory) {
            return _message;
        }
        function name() public view returns(string memory) { return _name; }
        function symbol() public view returns(string memory) { return _symbol; }
        function ownerOf(uint256 _tokenId) public view returns(address) {
            return
            _owners[_tokenId];
        }
        function getApproved(uint256 _tokenId) public view returns(address) {
            return _tokenApprovals[_tokenId];
        }
        function isApprovedForAll(address _owner, address _operator) public view
        returns(bool) {
            return
            _operatorApprovals[_owner][_operator];
        }
        function tokenURI(uint256 _tokenId) public view returns(string memory) {
            return _tokenUris[_tokenId];
        }
        function totalSupply() public view returns(uint256) {
            return
            nextTokenIdToMint;
        }
        function balanceOf(address _owner) public view returns(uint256) {
            require(_owner != address(0), "!Add0");
            return _balances[_owner];
        }
        function safeTransferFrom(address _from, address _to, uint256 _tokenId)
    public payable {
            safeTransferFrom(_from, _to, _tokenId, "");
        }
        function safeTransferFrom(address _from, address _to, uint256 _tokenId,
            bytes memory _data) public payable {
            require(ownerOf(_tokenId) == msg.sender || _tokenApprovals[_tokenId] ==
                msg.sender ||
                _operatorApprovals[ownerOf(_tokenId)][msg.sender], "!Auth");
            _transfer(_from, _to, _tokenId);
            require(_checkOnERC721Received(_from, _to, _tokenId, _data),
                "!ERC721Implementer");
        }
        function transferFrom(address _from, address _to, uint256 _tokenId)
    public payable {
            require(ownerOf(_tokenId) == msg.sender || _tokenApprovals[_tokenId] ==
                msg.sender ||
                _operatorApprovals[ownerOf(_tokenId)][msg.sender], "!Auth");
            _transfer(_from, _to, _tokenId);
        }
        function approve(address _approved, uint256 _tokenId) public payable {
            require(ownerOf(_tokenId) == msg.sender, "!Owner");
            _tokenApprovals[_tokenId] = _approved;
    emit Approval(ownerOf(_tokenId), _approved, _tokenId);
        }
        function setApprovalForAll(address _operator, bool _approved) public {
            _operatorApprovals[msg.sender][_operator] = _approved;
    emit ApprovalForAll(msg.sender, _operator, _approved);
        }
        function mintTo(address _to, string memory _uri) public {
            require(contractOwner == msg.sender, "!Auth");
            _owners[nextTokenIdToMint] = _to;
            _balances[_to] += 1;
            _tokenUris[nextTokenIdToMint] = _uri;
    emit Transfer(address(0), _to, nextTokenIdToMint);
            nextTokenIdToMint += 1;
        }
        function _checkOnERC721Received(address from, address to, uint256
    tokenId, bytes memory data) private
        returns(bool) {
            if (to.code.length > 0) {
                try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data)
                returns(bytes4 retval) {
                    return retval == IERC721Receiver.onERC721Received.selector;
                } catch (bytes memory reason) {
                    if (reason.length == 0) {
                        revert("ERC721: transfer to non ERC721Receiver implementer");
                    } else {
    assembly { revert(add(32, reason), mload(reason)) }
                    }
                }
            } else { return true; }
        }
        function _transfer(address _from, address _to, uint256 _tokenId) internal
        {
            require(ownerOf(_tokenId) == _from, "!Owner");
            require(_to != address(0), "!ToAdd0");
            delete _tokenApprovals[_tokenId];
            _balances[_from] -= 1;
            _balances[_to] += 1;
            _owners[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
        }
}