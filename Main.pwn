#define CGEN_MEMORY             (90000)
#pragma dynamic 				(50000)
 
#define FOREACH_NO_BOTS         // Disabled the "NPC", "Bot", and "Character" from iterators.
#define YSI_NO_HEAP_MALLOC      // The AMX is much larger because the allocation pool is embedded in the file.

/* Includes */   
#include <a_samp>
#include <YSI_Data\y_iterate>
#undef  MAX_PLAYERS
#define MAX_PLAYERS 200 
#pragma warning disable 203
#include <memory>
#include <map-zones> 
#include <a_mysql> 
#include <a_zones> 
#include <streamer>
#include <sscanf2>  
#include <gvar>
#include <crashdetect>
#include <YSI_Coding\y_timers>      		// by Y_Less from YSI
#include <YSI_Server\y_colours>            	// by Y_Less from YSI
#include <YSI_Storage\y_ini>				// by Y_Less from YSI
#include <easyDialog> 
#include <Pawn.CMD>
#include <FiTimestamp>
#define ENABLE_3D_TRYG_YSI_SUPPORT
#include <3DTryg>
#include <EVF2>
#include <nex-ac>                   //BY Nexus
#include <nex-ac_id.lang> 
#include <strlib>                   //by Slice
#include <sampvoice>
#include <selection>
#include <garageblock>
#include <cb>
#include <rAct>

#include <textdraw-streamer>
#include <progress2>

/* 
#define DCMD_PREFIX '!'
#include <discord-connector>
#include <discord-cmd>
*/
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~y~2",
	"~y~3",
	"~y~4",
	"~y~5"
};

new 
	WorldWeather = 1;

new MySQL: g_SQL;
 
/*enum
{
	NOTIFICATION_ERROR,
	NOTIFICATION_SUKSES,
	NOTIFICATION_WARNING,
	NOTIFICATION_INFO,
	NOTIFICATION_SYNTAX
};*/

/* Player Enums*/
enum E_PLAYERS
{
	pID,
	pUCP[22],
	pExtraChar,
	pChar,
	pName[MAX_PLAYER_NAME],
	pAdminname[MAX_PLAYER_NAME],
	pIP[16],
	pVerifyCode,
	pPassword[65],
	pSalt[17],
	pAdmin,
	pLevel,
	pLevelUp,
	pVip,
	pVipNameCustom[256],
	pVipTime,
	pRegDate[50],
	pLastLogin[50],
	pMoney,
	pRedMoney,
	STREAMER_TAG_3D_TEXT_LABEL:pMaskLabel,
	STREAMER_TAG_3D_TEXT_LABEL:pLabelDuty,
	pBankMoney,
	pSaldoGopay,
	pTargetGopay,
	pJumlahGopay,
	pBankRek,
	Smartphone,
	pPhone[32],
	pContact,
	pCall,
	pHours,
	pMinutes,
	pSeconds,
	pPaycheck,
	pSkin,
	pFacSkin,
	pGender,
	pUniform,
	pUsingUniform,
	pAge[50],
	pOrigin[32],
	pTinggiBadan,
	pBeratBadan,
	pInDoor,
	pInHouse,
	pInRusun,
	pInBiz,
	pInFamily,
	Float: pPosX,
	Float: pPosY,
	Float: pPosZ,
	Float: pPosA,
	pInt,
	pWorld,
	Float:pHealth,
    Float:pArmour,
	pHunger,
	pThirst,
	pHungerTime,
	pThirstTime,
	pStress,
	pStressTime,
	pInjured,
	pInjuredTime,
	pOnDuty,
	pFaction,
	pFactionRank,
	pTazer,
	pTaserGun,
	pLastShot,
	pShotTime,
	pStunned,
	pFamily,
	pFamilyRank,
	pJail,
	pJailTime,
	pJailReason[126],
	pJailBy[MAX_PLAYER_NAME],
	pArrest,
	pArrestTime,
	pWarn,
	pJob,
	pMask,
	pMaskID,
	pMaskOn,
	pHelmet,
	pGuns[13],
    pAmmo[13],
	pWeapon,
	Cache:Cache_ID,
	bool: IsLoggedIn,
	LoginAttempts,
	pSpawned,
	pAdminDuty,
	pAdminHide,

	//the star
	pTheStars,
	pTheStarsTime,

	pFreezeTimer,
	pFreeze,
	pSPY,
	pTogPM,
	pTogGlobal,
	pTogWT,
	Text3D:pAdoTag,
	bool:pAdoActive,

	Text3D:pLiveTag,
	
	pFlare,
	bool:pFlareActive,
	pFlareIcon[MAX_PLAYERS],

	pTrackCar,
	pTrackHoused,
	pCuffed,
	toySelected,
	bool:PurchasedToy,
	pEditingItem,
	pEditingAmmount,
	pProductModify,
	pCurrSeconds,
	pCurrMinutes,
	pCurrHours,
	pSpec,
	playerSpectated,
	pFriskOffer,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pHelmetOn,
	pSeatBelt,
	pReportTime,
	pAskTime,
	pActivity,
	pActivityStatus,
	pActivityTime,
	Float: ActivityTime,
	//Float: NotifyTime,
	pLoadingBar,
	pTimerLoading,
	pDiPesawat,
	//Jobs
	pSideJob,
	pSideJobTime,
	pSweeperTime,
	pBusTime,
	pMowerTime,
	pVehicleFaction,
	pMechVeh,
	pMechColor1,
	pMechColor2,
	EditingSAMPAHID,
	EditingPOMID,
	EditingATMID,
	EditingROBERID,
	EditingLADANGID,
	EditingUraniumID,
	EditingDeerID,
	bool: pOnBusJob,
	pTransfer,
	pTransferRek,
	pTransferName[128],
	gEditID,
	gEdit,
	piEditID,
	piEdit,
	pHead,
 	pPerut,
 	pLHand,
 	pRHand,
 	pLFoot,
 	pRFoot,
 	pDutyTimer,
	pPark,
	pACWarns,
	pACTime,
	pJetpack,
	pArmorTime,
	pLastUpdate,
	pBus,
	pSweeper,
	pMower,
	pSpeedTime,
	pLoopAnim,
	SelectBandara,
	SelectPelabuhan,
	SelectRusun,
	SelectRumah,
	SelectLastExit,
	pSelectItem,
	pListItem,
	pListItemGudang,
	pBagasiTake,
	pVehListItem,
	pStorageGudang,
	pGiveInv,
	pAmountInv,
	pPmin,
	pPsec,
	pBsec,
	pCSmin,
	pCSsec,
	pDipanggilan,
	pTargetAirdrop[10],
	pNamaAirdrop[32],
	pNomorAirdrop[32],
	pNominal,
	pRekening,
	pTargetFamily[10],
	pOnBadai,
	pGSec,
	pDutyPD,
	pDutyPemerintah,
	pDutyEms,
	pDutyBengkel,
	pDutyPedagang,
	pDutyGojek,
	pDutyTrans,
	pDutyKargo,
	pDutyFraksi,
	pRespawnVehJob,
	pTimerRespawn,
	pTimerSpawnKanabis,
	pEditingPenumpang,
	pSignalTime,
	pEarphone,
	pRadio,
	pAsapRokok,
	pHisapRokok,
	pMancing,
	Float: pBeratItem,
	Float: pRusunCapacity,
	Float: pGudangCapacity,
	pJerigenUse,
	bool:pActionActive,
	pHasGudangID,
	pGudangRentTime,
	pOwnedRusun,
	pInvenShow,
	Ktp,
	KtpTime,
	LastSpawn,
	Spawned,
	pRobSec,
	pRobMin,
	pPaycheckTime,
	pSimA,
	pSimB,
	pSimC,
	pSimD,
	pSimATime,
	pSimBTime,
	pSimCTime,
	pSimDTime,
	pGunLic,
	pGunLicTime,
	pHuntingLic,
	pHuntingLicTime,
	pStorageSelect,
	DownloadWhatsapp,
	DownloadSpotify,
	DownloadGojek,
	DownloadTwitter,
	EngineOn,
	pSpeedLimit,
	GarkotVehList,
	ClickSpawn,
	pInviteRusun,
	pInviteHouse,
	pInviteAccept,
	pKompensasi,
	pGoodMood,
	pOwnedHouse,
	pOpenBackpackTimer,
	pDealerVeh,
	pTempName[MAX_PLAYER_NAME],
	pTempValue,
	pTempVehID,
	pTempVehJobID,
	pTempSQLFactMemberID,
	pTempSQLFactRank,
	pTempSQLFamMemberID,
	pTempSQLFamRank,
	pTempText[320],
	pTempPlayerID,
	pTempCallNumber,
	pSKS,
	pSKSTime,
	pSKSNameDoc[128],
	pSKSRankDoc[128],
	pSKSReason[128],
	pSKCK,
	pSKCKTime,
	pSKCKNamePol[128],
	pSKCKRankPol[128],
	pSKCKReason[128],
	pBPJS,
	pBPJSTime,
	pBPJSLevel[128],
	pSKWB,
	pSKWBTime,
	pCarSeller,
    pCarOffered,
    pCarValue,
	pTogAutoEngine,
	phoneShown,
	pCaller,
	pDurringKarung,
	pTarget,
	pVehAudioPlay,
	hsAudioPlay,
	pHotlineTime,
	pTraceTime,
	TwitterName[128],
	TwitterPassword[128],
	Twitter,
	bool: pTurningEngine,
	bool: UsingDoor,
	bool: CurrentlyReadWA,
	bool: CurrentlyReadYellow,
	bool: CurrentlyReadTwitter,

	bool: EMSDuringReviving,

	pTrashmaster,
	pTrashmasterDelay,
	pLastVehicle,
	pDeliveryTime,
	pForkliftTime,
	pMixerTime,

	/* Dragging */
	pDragOffer,
	pFriendHouseID,

	//workshop
	pWorkshop,
	pWorkshopRank,

	pFixmeTime,
	pTempOlah,
	pClaimStarterpack,

	bEditID,
	bEdit,

	pEditSlotID,

	/* Taxi Stuffs */
	pTaxiDuty,
	pTaxiOrder,
	pTaxiPlayer,
	pTaxiFee,
	pTaxiRunDistance,
	Float:tPos[3],
	
	//saving
	aReceivedReports,
	aDutyTimer,
	pFashionItem,

	//notsave
	bool: AirdropPermission,
	bool:phoneAirplaneMode,
	bool:phoneDurringConversation,
	bool:phoneIncomingCall,
	phoneCallingWithPlayerID,
	phoneCallingTime,
	phoneCallRingtone[128],

	pFactDutyTimer,
	Float:pMapSettings,
	pMapRender,
	pSuspectTimer,
	bool: menuShowed,
	playerClickSpawn,
	pTogSpy,
	OnlineTimer,
	bool: ToggleFPS,
	DokterLokalTimer,

	//Twitter
	TwitterTime,

	pCheckpoint,
	pXmasTime,
	pTogAC,
	pStyleNotif,
	
	pShowFooter,
	pFooterTimer,

	//Afk System
	Float:pAFKPos[6],
	pAFK,
	pAFKTime,
	pAFKCode,

	pEditTextObject,
	pHUDMode,
	bool: pNameTagShown,
	bool: pNtagShown,

	bool: pFlashShown,
	bool: pFlashOn,

	pJobVehicle,

	//whatsapp
	pWAMessage,
	pLagiSpec,
	pLagiOpenInv,
	pOrangGeledah,
	Float:pRaceMMR,
	pRacingTime,
	pRaceMaxCP,
	pInRace,
	pRaceIndex,
	pRaceWith,
	pCheckpointEditing,
	pCurrentCheckpointIndex,
	pRobbingATM,
	pUsingOutfit,
	pOutfit[31],
	STREAMER_TAG_3D_TEXT_LABEL:NewbieLabel,
	pTempDialog,
	pTempAmount,
	pSmokedTimes,
	pIsSmokeBlowing,
	pMedicTime,
	pTempVehid,
	pDelayMixer,
	pNewBie,
	pNewBieTime
};
new AccountData[MAX_PLAYERS][E_PLAYERS];
new g_PlayerSpectating[MAX_PLAYERS];

new const g_aWeaponSlots[] = {
    0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 10, 10, 10, 10, 10, 10, 8, 8, 8, 0, 0, 0, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 4, 6, 6, 7, 7, 7, 7, 8, 12, 9, 9, 9, 11, 11, 11
};

enum {
    OUTFIT_PIKACHU = 0,
    OUTFIT_FROGHEAD,
    OUTFIT_SONIC,
    OUTFIT_CAPTAIN,
    OUTFIT_GOOFY,
    OUTFIT_DEMON,
    OUTFIT_VENOM,
	OUTFIT_DRAGON,
	OUTFIT_GRINCH,
	OUTFIT_ANGEL,
	OUTFIT_KILLER,
	OUTFIT_GHOST,
	OUTFIT_BALLON,
	OUTFIT_MICKY,
	OUTFIT_KROSH,
	OUTFIT_NINJA_TURTLE,
	OUTFIT_STICH,
	OUTFIT_TOPPLE,
	OUTFIT_KAONASHI,
	OUTFIT_SIMPSON,
	OUTFIT_RABBIT,
	OUTFIT_MINECRAFT,
	OUTFIT_EMOJI_LOVE,
	OUTFIT_EMOJI_SMILE,
	OUTFIT_EMOJI_YUM,
	OUTFIT_EMOJI_TONGUE,
	OUTFIT_MONSTER_RAINBOW,
	OUTFIT_POOP,
	OUTFIT_ANGRYBIRD,
	OUTFIT_BANANA,
	OUTFIT_JERRY,
	OUTFIT_MAX

};

new ListedItems[MAX_PLAYERS][100];

enum
{
	DIALOG_MAKE_CHAR,
	DIALOG_CHARLIST,
	DIALOG_VERIFYCODE,
	DIALOG_UNUSED,
    DIALOG_REGISTER,
    DIALOG_AGE,
	DIALOG_ORIGIN,
	DIALOG_TINGGIBADAN,
	DIALOG_BERATBADAN,
	DIALOG_GENDER,
	DIALOG_TOY,
	DIALOG_TOYEDIT,
	DIALOG_TOYEDIT_ANDROID,
	DIALOG_TOYPOSISI,
	DIALOG_TOYPOSISIBUY,
	DIALOG_TOYVIP,
	DIALOG_TOYPOSX,
	DIALOG_TOYPOSY,
	DIALOG_TOYPOSZ,
	DIALOG_TOYPOSRX,
	DIALOG_TOYPOSRY,
	DIALOG_TOYPOSRZ,
	DIALOG_TOYPOSSX,
	DIALOG_TOYPOSSY,
	DIALOG_TOYPOSSZ,
	DIALOG_HELP,
	DIALOG_EDITBONE,
	DIALOG_REPORTS,
	DIALOG_REPORTSREPLY,
	DIALOG_ASKS,
	DIALOG_ASKSREPLY,
	DIALOG_HEALTH,
	DIALOG_TDM,
	DIALOG_DISNAKER,
	DIALOG_MEMBERI,
	DIALOG_SETAMOUNT,
	DIALOG_MODIF,
	DIALOG_MODIF_VELG,
	DIALOG_MODIF_SPOILER,
	DIALOG_MODIF_HOODS,
	DIALOG_MODIF_VENTS,
	DIALOG_MODIF_LIGHTS,
	DIALOG_MODIF_EXHAUSTS,
	DIALOG_MODIF_FRONT_BUMPERS,
	DIALOG_MODIF_REAR_BUMPERS,
	DIALOG_MODIF_ROOFS,
	DIALOG_MODIF_SIDE_SKIRTS,
	DIALOG_MODIF_BULLBARS,
	DIALOG_MODIF_NEON,
	
	DIALOG_STREAMER_CONFIG,
	DANN_RENTAL,
	DANN_UNRENT,
	DANN_ASURANSI,
	DANN_BUYALATSTEAL,
	DANN_PILIHSPAWN,
	DANN_PICKUPVEH,
	DANN_DYNHELP,

	DIALOG_RUSUN,
	DIALOG_RUSUN_OWNED,
	DIALOG_RUSUN_BRANKAS,
	DIALOG_RUSUN_INVITE,
	DIALOG_RUSUN_INVITECONF,
	DIALOG_RUSUN_BROPTION,
	DIALOG_RUSUN_MENU,
	DIALOG_RUSUNOWNED,
	DIALOG_RUSUNOPENSTORAGE,
	DIALOG_RUSUNITEM,

	DIALOG_RUSUNVAULT_DEPOSIT,
	DIALOG_RUSUNVAULT_WITHDRAW,
	DIALOG_RUSUNVAULT_IN,
	DIALOG_RUSUNVAULT_OUT,
	
	DIALOG_KAYU_START,
	DIALOG_SUSU_START,
	DIALOG_MINYAK_START,
	DIALOG_AYAM_START,
	DIALOG_MOWER_START,
	DIALOG_STEAL_SHOP,
	DIALOG_IKEA_MENU,
	DIALOG_IKEA_BESI,
	DIALOG_IKEA_BERLIAN,
	DIALOG_IKEA_EMAS,
	DIALOG_IKEA_TEMBAGA,
	DIALOG_IKEA_AYAMKEMAS,
	DIALOG_IKEA_KAYUKEMAS,
	DIALOG_IKEA_GAS,
	DIALOG_IKEA_PAKAIAN,

	DIALOG_FARMER_OLAH,
	DIALOG_LOUNGES_MASAK,
	DIALOG_HUNTING_SELL,
	DIALOG_BAGASISTORAGE,

	DIALOG_GUDANG,
	DIALOG_GUDANGSTOP,
	DIALOG_GUDANGOPTION,
	DIALOG_GUDANGOWNED,
	DIALOG_GUDANGITEM,
	DIALOG_GUDANGDEPOSIT,
	DIALOG_GUDANGWITHDRAW,

	LokasiGps,
	LokasiUmum,
	LokasiPekerjaan,
	LokasiHobi,
	LokasiPertokoan,
	DialogWarung,
	BeliNasduk,
	BeliAqua,
	BeliUmpan,
	DialogGadget,
	DANN_BOOMBOX,
	DANN_BOOMBOX1,
	DialogSpotify,
	DialogSpotify1,
	DialogFish,
	DialogCargo,
	DialogSpawn,
	DialogDropItem,
	DialogTransfer,
	DialogTransfer1,
	DialogBankConfirm,
	DialogElist,
	// -----------
	DialogShowroom,
	DialogAsuransi,
	// -------------
	DialogKontak,
	DialogOpenContact,
	DialogContact,
	DialogTelepon,
	DialogContactMenu,
	DialogGarasiKota,
	DialogMyVeh,
	DialogTrackMyVeh,
	DialogBagasi,
	// -----------
	DialogToyEdit,

	DIALOG_CRAFTING,
	DIALOG_CRAFTINGCONF,
	DIALOG_FAMILY_PANEL,
	DIALOG_FAMSTAKE_REDMONEY,
	DIALOG_FAMSTAKE_MONEY,
	DIALOG_FAMGARAGE_OUT,
	DIALOG_BLACKMARKET,
	
	DIALOG_DEPOSIT_POLICE,
	DIALOG_WITHDRAW_POLICE,

	DIALOG_POLVAULT,
	DIALOG_POLVAULT_DEPOSIT,
	DIALOG_POLVAULT_WITHDRAW,
	DIALOG_POLVAULT_IN,
	DIALOG_POLVAULT_OUT,

	DIALOG_POLICE_PANEL,
	DIALOG_POLICE_BOSDESK,
	DIALOG_POLICESETRANK,
	DIALOG_POLICEKICKMEMBER,
	DIALOG_RANK_SET_POLISI,
	DIALOG_POLICE_INVITE,
	DIALOG_POLICE_GARAGE,
	DIALOG_POLICE_GARAGE_BUY,
	DIALOG_POLICE_GARAGE_DEL,
	DIALOG_POLICE_HELI_GARAGE,
	DIALOG_POLICE_HELI_BUY,
	DIALOG_POLICE_HELI_GARAGE_OUT,
	DIALOG_POLICE_GARAGE_OUT,
	DIALOG_POLICE_IMPOUND,
	DIALOG_POLICE_TAKE_IMPOUND,
	DIALOG_FEDERAL_GARAGE,
	DIALOG_FEDERAL_GARAGE_BUY,
	DIALOG_FEDERAL_GARAGE_OUT,
	DIALOG_PDM,
	DIALOG_PDM_VEHICLE,
	DIALOG_PDM_VEHICLE_IMPOUND,
	DIALOG_PDM_OBJECT,
	DIALOG_ADD_HKRIMINAL,
	DIALOG_REMOVE_HKRIMINAL,
	
	DIALOG_EMS_PANEL,
	DIALOG_EMS_GARAGE,
	DIALOG_EMS_GARAGE_BUY,
	DIALOG_EMS_GARAGE_TAKEOUT,
	DIALOG_EMS_GARAGE_DELETE,
	DIALOG_EMSBRANKAS,
	DIALOG_EMSBKCONFIRM,
	DIALOG_EMS_BOSDESK,
	DIALOG_EMS_INVITE,
	DIALOG_EMS_LOCKER,
	DIALOG_EMS_CLOTHES,
	DIALOG_EMSSETRANK,
	DIALOG_EMSKICKMEMBER,
	DIALOG_RANK_SET_EMS,
	DIALOG_DEPOSIT_EMS,
	DIALOG_WITHDRAW_EMS,

	DIALOG_EMSVAULT,
	DIALOG_EMSVAULT_DEPOSIT,
	DIALOG_EMSVAULT_WITHDRAW,
	DIALOG_EMSVAULT_IN,
	DIALOG_EMSVAULT_OUT,
	// ------------------ PEMERINTAH
	DIALOG_PEMERINTAH_LOCKER,
	DIALOG_PEMERINTAH_LOCKERMALE,
	DIALOG_PEMERINTAH_LOCKERFEMALE,
	DIALOG_PEMERINTAH_PANEL,
	DIALOG_PEMERINTAH_BOSDESK,
	DIALOG_PEMERSETRANK,
	DIALOG_PEMERKICKMEMBER,
	DIALOG_RANK_SET_PEMERINTAH,
	DIALOG_PEMERINTAH_INVITE,
	DIALOG_PEMERINTAH_DEPOSIT,
	DIALOG_PEMERINTAH_WITHDRAW,
	DIALOG_PEMER_GARAGE,
	DIALOG_PEMER_GARAGE_BUY,
	DIALOG_PEMER_GARAGE_TAKEOUT,
	DIALOG_PEMER_GARAGE_DELETE,
	
	DIALOG_PEMERVAULT,
	DIALOG_PEMERVAULT_DEPOSIT,
	DIALOG_PEMERVAULT_WITHDRAW,
	DIALOG_PEMERVAULT_IN,
	DIALOG_PEMERVAULT_OUT,

	DIALOG_PEDSETRANK,
	DIALOG_PEDKICKMEMBER,
	DIALOG_RANK_SET_PEDAGANG,
	DIALOG_LOCKERPEDAGANG,
	DIALOG_PEDAGANG_GARAGE,
	DIALOG_PEDAGANG_GARAGE_BUY,
	DIALOG_PEDAGANG_GARAGE_TAKEOUT,
	DIALOG_PEDAGANG_GARAGE_DELETE,

	DIALOG_BENGKEL_PANEL,
	DIALOG_BENGKEL_LOCKER,
	DIALOG_BENGKEL_CLOTHES,
	DIALOG_BENGKEL_GARAGE,
	DIALOG_MODIF_COLOROPTION,
	DIALOG_MODIF_WARNA1,
	DIALOG_MODIF_WARNA2,
	DIALOG_MODIF_PAINTJOB,
	DIALOG_BENGKELBUYVEH,
	DIALOG_BENGKELTAKEVEH,
	DIALOG_BENGKEL_BRANKASOPTION,
	DIALOG_BENGKEL_BRANKASITEM,
	DIALOG_BENGKEL_BRANKASCONF,
	DIALOG_BENGKEL_BRANKASREPAIRKIT,
	DIALOG_BENGKEL_BRANKASTOOLSKIT,
	DIALOG_BENGKEL_BOSDESK,
	DIALOG_BENGKEL_INVITE,
	DIALOG_BENGKELSETRANK,
	DIALOG_BENGKELKICKMEMBER,
	DIALOG_RANK_SET_BENGKEL,
	DIALOG_BENGKELDELCAR,
	DIALOG_DEPOSIT_BENGKEL,
	DIALOG_WITHDRAW_BENGKEL,

	DIALOG_BENGVAULT,
	DIALOG_BENGVAULT_DEPOSIT,
	DIALOG_BENGVAULT_WITHDRAW,
	DIALOG_BENGVAULT_IN,
	DIALOG_BENGVAULT_OUT,

	DIALOG_BOSDESK_GOJEK,
	DIALOG_DEPOSIT_GOJEK,
	DIALOG_WITHDRAW_GOJEK,
	DIALOG_RANK_SET_GOJEK,
	DIALOG_GOJEK_INVITECONF,
	DIALOG_GOJEK_LOCKER,

	DIALOG_GOJEK_GARAGE,
	DIALOG_GOJEK_GARAGE_BUY,
	DIALOG_GOJEK_GARAGE_TAKEOUT,
	DIALOG_GOJEK_GARAGE_DELETE,

	DIALOG_GOJVAULT,
	DIALOG_GOJVAULT_DEPOSIT,
	DIALOG_GOJVAULT_WITHDRAW,		
	DIALOG_GOJVAULT_IN,	
	DIALOG_GOJVAULT_OUT,

	DIALOG_PAYGOJEK,
	DIALOG_PAYGOJEKAMOUNT,
	DIALOG_TOPUPGOJEK,
	DIALOG_PESANGORIDE,
	DIALOG_PESANGORIDECONF,
	DIALOG_PESANGOCAR,
	DIALOG_PESANGOCARPENUMPANG,
	DIALOG_PESANGOCARCONF,
	DIALOG_GOPAYWITHDRAW,
	
	DIALOG_GOFOOD_PESAN,
	DIALOG_PESAN_NASIGORENG,
	DIALOG_PESAN_BAKSO,
	DIALOG_PESAN_NASIPECEL,
	DIALOG_PESAN_BUBUR,
	DIALOG_PESAN_SUSU,
	DIALOG_PESAN_ESTEH,
	DIALOG_PESAN_KOPI,
	DIALOG_PESAN_CHOCOMATCH,
	DIALOG_PESAN_NOTES,
	
	DIALOG_ITEM_PICKUP,

	DIALOG_FAMSVAULT,
	DIALOG_FAMSVAULT_DEPOSIT,
	DIALOG_FAMSVAULT_WITHDRAW,
	DIALOG_FAMSRM_VAULT,
	DIALOG_FAMSRM_DEPOSIT,
	DIALOG_FAMSRM_WITHDRAW,
	DIALOG_FAMSVAULT_IN,
	DIALOG_FAMSVAULT_OUT,
	DIALOG_FAMSBRANKAS,
	DIALOG_FAMS_WEAPON,
	DIALOG_FAMILIESSETRANK,
	DIALOG_FAMILIESKICKMEMBER,
	DIALOG_RANK_SET_FAMILIES,

	DIALOG_VEHICLE_MENU,
	DIALOG_VHOLSTER,
	DIALOG_VHOLSTER_WITHDRAW,

	DIALOG_SPORTSTORE,

	/* Trans Dialog */
	DIALOG_TRANSORDER,
	DIALOG_TRANS_LOCKER,
	DIALOG_TRANS_DESK,
	DIALOG_TRANSSETRANK,
	DIALOG_TRANSKICKMEMBER,
	DIALOG_RANK_SET_TRANS,
	DIALOG_TRANS_INVITECONF,
	DIALOG_DEPOSIT_TRANS,
	DIALOG_WITHDRAW_TRANS,
	DIALOG_TRANS_GARAGE,
	DIALOG_TRANS_GARAGE_TAKEOUT,
	DIALOG_TRANS_GARAGE_BUY,
	DIALOG_TRANS_GARAGE_DELETE,

	DIALOG_TRANSVAULT,
	DIALOG_TRANSVAULT_DEPOSIT,
	DIALOG_TRANSVAULT_WITHDRAW,
	DIALOG_TRANSVAULT_IN,
	DIALOG_TRANSVAULT_OUT,

	/*Event Dialog*/
	DIALOG_EVENT_SETTING,
	DIALOG_EVENT_REDSKIN,
	DIALOG_EVENT_REDWEAP1,
	DIALOG_EVENT_REDWEAP2,
	DIALOG_EVENT_REDWEAP3,

	DIALOG_EVENT_BLUESKIN,
	DIALOG_EVENT_BLUEWEAP1,
	DIALOG_EVENT_BLUEWEAP2,
	DIALOG_EVENT_BLUEWEAP3,

	DIALOG_EVENT_WWID,
	DIALOG_EVENT_INTID,
	DIALOG_EVENT_TIME,
	DIALOG_EVENT_TARGETSCORE,
	DIALOG_EVENT_PARTICIPRIZE,
	DIALOG_EVENT_PRIZE,
	DIALOG_EVENT_HEALTH,
	DIALOG_EVENT_ARMOUR,

	/* Dialog Aridrop */
	DIALOG_AIRDROP,
	DIALOG_AIRDROPDISPLAY,
	DIALOG_AIRDROP_CONF,
	DIALOG_ADD_CONTACT,
	DIALOG_ADD_CONTACTNUMB,
	DIALOG_EDIT_CONTACTNAME,
	DIALOG_EDIT_CONTACTNUMBER,

	/* Dialog Garasi Umum */
	DIALOG_GARKOT_OUT,

	/* Dialog Gudang */
	DIALOG_GUDANG_BUY,
	DIALOG_GUDANG_OPTION,
	DIALOG_GUDANGVAULT,
	DIALOG_GUDANGVAULT_DEPOSIT,
	DIALOG_GUDANGVAULT_WITHDRAW,
	DIALOG_GUDANGVAULT_IN,
	DIALOG_GUDANGVAULT_OUT,

	/* Score Board Admin Menu */
	DIALOG_CLICKPLAYER,
	DIALOG_BANNEDTIME,
	DIALOG_BANNEDREASON,

	/* Dialog Asuransi */
	DIALOG_ASURANSI_LS,
	DIALOG_ASURANSI_LV,
	DIALOG_ASURANSI_SF,

	/* Dialog Fact Garage */
	DIALOG_FACTION_GARAGE_MENU,
	DIALOG_FACTION_GARAGE1,
	DIALOG_FACTION_GARAGE2,
	DIALOG_FACTION_GARAGE3,
	DIALOG_FACTION_GARAGE4,
	DIALOG_FACTION_GARAGE5,
	DIALOG_FACTION_GARAGE6,

	/* Dialog warung */
	DIALOG_WARUNG,
	DIALOG_WARUNG_ELEKTRONIK, 
	DIALOG_BUY_NASIUDUK,
	DIALOG_BUY_AIRMINERAL, 
	DIALOG_BUY_UMPAN,

	/* Petani Dialog */
	DIALOG_BUY_SEEDS,
	DIALOG_BIBIT_PADI,
	DIALOG_BIBIT_TEBU,
	DIALOG_BIBIT_CABE,

	/* Dialog House Keys */
	DIALOG_HKEYS, 
	DIALOG_HKEYS_ADD,
	DIALOG_HKEYS_REMOVE,
	DIALOG_HOUSEGARAGE_OUT,
	DIALOG_HOUSEHELIPAD_OUT,
	DIALOG_HOUSE_BRANKAS,
	DIALOG_HOUSE_INVITE,
	DIALOG_HOUSE_INVITECONF,
	DIALOG_HOUSEVAULT,
	DIALOG_HOUSEVAULT_DEPOSIT,
	DIALOG_HOUSEVAULT_WITHDRAW,
	DIALOG_HOUSEVAULT_IN,
	DIALOG_HOUSEVAULT_OUT,
	DIALOG_WEAPON_CHEST,

	DIALOG_FIXMEACC,
	DIALOG_ADMIN_HELP,
	DIALOG_DYNAMIC_HELP,

	DIALOG_SWEEPER_START,
	DIALOG_DELIVERY_START,
	DIALOG_FORKLIFT_START,
	DIALOG_RECYCLER_START,
	DIALOG_TRASHMASTER_START,

	/* Dialog Clothes */
	DIALOG_CLOTHES,
	DIALOG_CLOTHES_DELETE,

	/* Atms Dialog */
	DIALOG_ATM_WITHDRAW,
	DIALOG_ATM_DEPOSIT,
	DIALOG_ATM_TRANSFER,
	DIALOG_ATM_TRANSFER1,

	DIALOG_CART,
	DIALOG_ORDERS,
	DIALOG_ORDER_DETAILS,

	/* Carsteal Dialog */
	DIALOG_CARSTEAL_SHOP,

	/*Whatsapp Dialog*/
	DIALOG_WHATSAPP_CHAT,
	DIALOG_WHATSAPP_CHAT_EMPTY,
	DIALOG_WHATSAPP_SEND,

	/*Yellow Pages*/
	DIALOG_YELLOW_PAGE,
	DIALOG_YELLOW_PAGE_MENU,
	DIALOG_YELLOW_PAGE_EMPTY,
	DIALOG_YELLOW_PAGE_SEND,
	DIALOG_YELLOW_CALL,

	/*Tweets Dialog*/
	DIALOG_TWITTER_SIGN,
	DIALOG_TWITTER_SIGNPASSWORD,
	DIALOG_TWITTER_LOGIN,
	DIALOG_TWITTER_LOGINPASSWORD,
	DIALOG_TWITTER_POST,
	DIALOG_TWITTER_POST_EMPTY,
	DIALOG_TWITTER_POST_SEND,

	/*Invoice Dialog*/
	DIALOG_INVOICE_NAME,
    DIALOG_INVOICE_COST,
    DIALOG_PAY_INVOICE,

	/*Player dialog*/
	DIALOG_PLAYER_MENU,
	DIALOG_PLAYER_DOKUMENT,

	/*Job Mixer Dialog*/
	DIALOG_MIXER,

	DIALOG_SELECT_SPAWN,
	DIALOG_SELECT_SPAWNEXPIRED,

	DIALOG_SHOWROOM_MENU,
	DIALOG_SHOWROOM_SELL,

	DIALOG_WEAPONSHOP,
	DIALOG_VIP_NAME,
	DIALOG_SELLFISH_ILEGAL,
	DIALOG_DISPLAYBANNED,
	DIALOG_RADIO_FREQ,
	DIALOG_VOICEMODE,
	DIALOG_VOICEKEYS,
	DIALOG_INVENTORY,
	DIALOG_CHANGE_PASSWORD,
	DIALOG_MYV_MENU,
	DIALOG_VEHICLE_DETAIL,
	DIALOG_UPGRADE,
	DIALOG_MODSHOP,

	//BISNIS STUFFS
	DIALOG_SELL_BISNISS,
	DIALOG_SELL_BISNIS,
	DIALOG_MY_BISNIS,
	BISNIS_MENU,
	BISNIS_INFO,
	BISNIS_NAME,
	BISNIS_VAULT,
	BISNIS_WITHDRAW,
	BISNIS_DEPOSIT,
	BISNIS_BUYPROD,
	BISNIS_EDITPROD,
	BISNIS_PRICESET,

	// WORKSHOP
	/*WORKSHOP_MENU,
	WORKSHOP_NAME,
	WORKSHOP_INFO,
	WORKSHOP_MONEY,
	WORKSHOP_WITHDRAWMONEY,
	WORKSHOP_DEPOSITMONEY,
	WORKSHOP_COMPONENT,
	WORKSHOP_WITHDRAWCOMPONENT,
	WORKSHOP_DEPOSITCOMPONENT,
	WORKSHOP_SERVICE,
	WORKSHOP_REPAIRKIT,*/

	//SETTINGS
	DIALOG_SETTINGS,

	DIALOG_WEAPON_CHEST_PD,
	DialogSpotifyHp,
	DialogBankHp,
	DialogTw,
	DialogAccRedMoney,
	DialogAccMoney,
	DIALOG_CRAFTINGKEVLAR,
	DIALOG_CRAFTINGCONFKEV,
	DIALOG_BAHANPEDAGANG,
	DIALOG_BUYINPUT,
	DIALOG_CONFBUYINP
}

new AksesorisHat[87] =
{
	18953, 18954, 19554, 18960, 18974, 19067, 19068, 19069, 18891, 18892, 18893, 18894, 18895, 18896, 18897, 18898, 18899, 18900, 18908,
	18940, 18939, 18941, 18942, 18943, 19160, 18636, 18926, 18927, 18928, 18929, 18930, 18931, 18932, 18933, 18934, 18935, 18952, 18976, 18977, 
	18979, 19077, 19517, 19161, 19162, 2054, 18961, 18964, 18965, 18966, 19558, 18955, 18956, 18957, 18958, 18959, 18638, 19520, 18947, 18948, 
	19064,19065, 19066, 18975, 19516, 18639, 18645, 18962, 19095, 19096, 19099, 19100, 19487, 19136, 19330, 19331, 19137, 19528, 19093,
	3002, 3000, 3100, 3105, 3104, 3101, 3102, 3103, 3002,
};

new BackpackToys[8] = 
{
	11745, 19559, 1550, 3026, 371, 1210, 11738, 18637,
};

new GlassesToys[33] = 
{
	19138, 19139, 19140, 19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015, 19016, 19017, 19018,
	19019, 19020, 19021, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035,
};

new AksesorisToys[38] = 
{
	19515, 19142, 19621, 19623, 
	19584, 19591, 19592, 2226, 19878, 
	19038, 19036, 19163, 18919, 18912, 
	18913, 18914, 18915, 18916, 18917, 
	18918, 18911, 18920, 11704, 19037, 
	19317, 19318, 336, 339, 325, 19625,
	19801, 19163, 19904, 2226, 2487, 2614,
	11712, 18635,
};

new ClothesSkinMale[166] = 
{
    1, 2, 3, 4, 5, 6, 7, 8, 14, 15, 16, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, //23
    30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 58, 59, 60, 61, //21
    62, 66, 67, 68, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 86, 94, 95, 96, 97, 98, 100, //21
    101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, //16
    117, 118, 120, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 142, //16
    143, 144, 146, 147, 149, 153, 154, 156, 158, 159, 160, 161, 162, 168, 170, 173, 174, //17
    175, 176, 177, 179, 180, 182, 183, 184, 185, 186, 187, 200, 202, 203, 204, 206, //16
    208, 213, 217, 220, 221, 222, 223, 229, 239, 240, 241, 242, 247, 248, //17
    249, 250, 252, 253, 254, 255, 258, 259, 260, 262, 264, 269, 270, 271, 272, 273, //16
    289, 290, 291, 292, 293, 296, 297, 299 //8
};

new ClothesSkinFemale[60] = 
{
	9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 65, 69, 75, 76, 77, 87,
	88, 89, 90, 91, 93, 129, 130, 131, 138, 139, 140, 145, 148, 151, 152, 157, 169, 178, 191,
	193, 192, 195, 196, 197, 198, 199, 205, 207, 211, 214, 216, 219, 224, 225, 226, 233, 237, 
	251
};

stock const Float: SpawnPelabuhan[][] = {
	{2809.9089,-2437.0984,13.6551,90.0947},
	{2809.9089,-2437.0984,13.6551,90.0947},
	{2809.9089,-2437.0984,13.6551,90.0947}
};

stock const Float: SpawnBandara[][] = {
	{1683.85, -2326.48, 13.54, 5.01}
};

stock const Float: SpawnStasiun[][] = {
	{823.8370, -1361.8326, -0.5078, 316.9551},
	{823.8370, -1361.8326, -0.5078, 316.9551}
};

hook native TogglePlayerSpectating(playerid, bool:toggle) {
	g_PlayerSpectating[playerid] = toggle;
	SetPVarInt(playerid, "SpectateGuard", 1);
	return continue(playerid, _:toggle);
}
hook native SetPlayerHealth(playerid, Float:health) {
	// PrintBacktrace();
	return continue(playerid, _:health);
}

#include "SERVER/utils/utils_defines"
#include "SERVER/utils/utils_vehiclevars"
#include "SERVER/utils/utils_enums"
#include "SERVER/utils/utils_variable"
#include "SERVER/utils/utils_colours"
#include "SERVER/utils/utils_textdraws"
#include "SERVER/utils/utils_keyaction"
#include "SERVER/voucher/voucher_functions"

#include "SERVER/systems/Pickup"
#include "SERVER/systems/JobVehicles"

/*Clothes System*/
#include "SERVER/toys/toys"
#include "SERVER/toys/toys_helmet"
#include "SERVER/clothes/clothes_functions"

#include "SERVER/fuel_system/fuel_functions"
#include "SERVER/PlayerStuff/player_slot"
#include "SERVER/Gym/gym_functions"

#include "SERVER/Dynamic/Dynamic_SpeedCam/core"
#include "SERVER/Dynamic/Dynamic_SpeedCam/funcs"
#include "SERVER/Dynamic/Dynamic_SpeedCam/cmd"
#include "SERVER/Dynamic/Dynamic_Button/button_functions"
#include "SERVER/Dynamic/Dynamic_Actor/ui_dynactor"
#include "SERVER/Dynamic/Dynamic_Warung/warung_functions"
#include "SERVER/Dynamic/Dynamic_Pasar/dyn_pasar"
#include "SERVER/Dynamic/Dynamic_Robbery/robbery_functions"
#include "SERVER/Dynamic/Dynamic_Pintu/Core.pwn"
///#include "SERVER/Dynamic/Dynamic_Workshop/workshop_func"
//#include "SERVER/area/area"
#include "SERVER/area/areanew"
#include "SERVER/Dynamic/Dynamic_Hunting/hunting_functions"
#include "SERVER/Dynamic/Dynamic_Ladang/ui_dynkanabis"
#include "SERVER/Dynamic/Dynamic_Ladang/kanabis_olah"
#include "SERVER/Dynamic/Dynamic_Object/object_funcs"


#include "SERVER/Dynamic/Dynamic_GarasiKota/Header"
#include "SERVER/Dynamic/Dynamic_GarasiKota/Function"
#include "SERVER/Dynamic/Dynamic_GarasiKota/Commands"

#include "SERVER/PlayerStuff/player_robminigame"
#include "SERVER/Dynamic/Dynamic_Atm/ui_atm"
#include "SERVER/Dynamic/Dynamic_Garbage/dynamic_garbage"
#include "SERVER/Dynamic/Dynamic_Door/dynamic_doors"
#include "SERVER/Dynamic/Dynamic_Gate/dynamic_gatev2"
#include "SERVER/Dynamic/Dynamic_Gudang/gudang_functions"
#include "SERVER/Dynamic/Dynamic_Label/label_functions"

// Map Icon
#include "SERVER/Dynamic/Dynamic_IconMap/Header"
#include "SERVER/Dynamic/Dynamic_IconMap/Function"
#include "SERVER/Dynamic/Dynamic_IconMap/Commands"

#include "SERVER/Dynamic/Dynamic_Machine/dynamic_slot"
#include "SERVER/Dynamic/Dynamic_ObjectText/objecttext"
#include "SERVER/Dynamic/Dynamic_Uranium/uranium_funcs"
#include "SERVER/Dynamic/Dynamic_Workshop/Function"

#include "SERVER/Dynamic/Dynamic_Race/Race.pwn"
// #include "SERVER/Dynamic/Dynamic_FactionStuffs/dynamic_factiongarage.inc"
 
#include "SERVER/jobs/farmer/petani_functions"

#include "SERVER/inventory/inventory_functions"
#include "SERVER/inventory/inventory_cmds" 
#include "SERVER/inventory/inventory_drop"

#include "SERVER/voice/radiosystem"

// ------------------------------------------
#include "SERVER/user-interface/ui_animations"
//#include "SERVER/user-interface/notifikasi/Header"
//#include "SERVER/user-interface/notifikasi/Function"
#include "SERVER/user-interface/notifikasi/box_func"
#include "SERVER/user-interface/notifikasi/ui_notif2"
//#include "SERVER/user-interface/ui_shortkeys"
#include "SERVER/user-interface/ui_shortkeysnew"
#include "SERVER/user-interface/ui_smoking"

#include "SERVER/Dynamic/Dynamic_Rusun/rusun_functions"
#include "SERVER/Dynamic/Dynamic_House/dyn_house"

#include "SERVER/PlayerStuff/PlayerAFK"
#include "SERVER/PlayerStuff/IdleAnimation"
#include "SERVER/PlayerStuff/NameTag"
#include "SERVER/PlayerStuff/player_login"

/*PhoneSystem*/
#include "SERVER/FractionPlayer/FAMILIES/families_functions"
// #include "SERVER/FractionPlayer/FAMILIES/families_garage.inc"

#include "SERVER/jobs/miner/minerv2_functions"
#include "SERVER/jobs/lumberjack/lumber_functions"
#include "SERVER/jobs/bus/bus_funcs"
#include "SERVER/jobs/chicken factory/butcher_functions"
#include "SERVER/jobs/milker/milker_functions"
#include "SERVER/jobs/oilman/oilman_function"
#include "SERVER/jobs/fisherman/nelayan_funcs"
#include "SERVER/jobs/delivery/deliveryside_functions"
#include "SERVER/jobs/mowingjob/mowerside_functions"
#include "SERVER/jobs/sweeper/sweeper_functions"
#include "SERVER/jobs/forklift/forkliftside_functions"
#include "SERVER/jobs/tailor/tailorv2_functions"
#include "SERVER/jobs/tailor/tailor_forward"
#include "SERVER/jobs/hauling/kargo_func"
#include "SERVER/jobs/RicycleJob/recycler_functions"
#include "SERVER/jobs/trashmaster/trashmaster_functions"
#include "SERVER/jobs/electrican/electric_funcs"
#include "SERVER/jobs/mixer/callback"

#include "SERVER/Dynamic/Dynamic_Garbage/rongsokan_functions"
#include "SERVER/PlayerSmartphone/smartphone_contacts"
#include "SERVER/PlayerSmartphone/phone_funcs"
#include "SERVER/alenscripts/phone_new"
#include "SERVER/alenscripts/function_new"
#include "SERVER/alenscripts/radial-player"
#include "SERVER/alenscripts/bahan-pedagang"
#include "SERVER/alenscripts/remove-vanding"
#include "SERVER/alenscripts/warga-baru"
#include "SERVER/alenscripts/document-player/ktp"

#include "SERVER/vehiclemod/modshop"
#include "SERVER/vehicles/vehicles_functions"
#include "SERVER/vehicles/vehicles_cmds"

#include "SERVER/weapons/weapons_functions"

#include "SERVER/Dynamic/Dynamic_Rental/dyn_rental"

#include "SERVER/FractionPlayer/stuff_goodside"

#include "SERVER/toko-olahraga/business_olahraga"

/* Factions */
#include "SERVER/FractionPlayer/FactionMenu"
#include "SERVER/FractionPlayer/FactionOnline"
#include "SERVER/FractionPlayer/Pemerintah/pemerintah_functions"
#include "SERVER/FractionPlayer/Bengkel/bengkel_brankas"
#include "SERVER/FractionPlayer/Bengkel/bengkel_functions"
#include "SERVER/FractionPlayer/Pedagang/lounges_brankas"
#include "SERVER/FractionPlayer/Pedagang/lounges_vars"
#include "SERVER/FractionPlayer/Pedagang/lounges_functions"
#include "SERVER/FractionPlayer/EMS/ems_brankas"
#include "SERVER/FractionPlayer/EMS/ems"
// #include "SERVER/FractionPlayer/EMS/medic_funcs"
#include "SERVER/FractionPlayer/Police/sapd_functions"
// #include "SERVER/FractionPlayer/Police/sapd_taser"
// #include "SERVER/FractionPlayer/Police/sapd_spike"
#include "SERVER/FractionPlayer/trans/trans_functions"
#include "SERVER/FractionPlayer/trans/trans_stuffs"
// #include "SERVER/FractionPlayer/Gojek/cmds_gojek"
// #include "SERVER/FractionPlayer/Gojek/gojek_functions"

#include "SERVER/reports/systems_ask"
#include "SERVER/reports/systems_reports"

#include "SERVER/systems/LiveStream"
#include "SERVER/events/balapan.inc"//balap
#include "SERVER/events/admin_events.inc"
#include "commands/cmds_hooks"
#include "SERVER/systems/systems_dialogs"
// #include "SERVER/systems/systems_spawn.inc" Dimatikan sementara
#include "SERVER/systems/systems_functions"
#include "SERVER/systems/systems_native"
//---------{ANTICHEAT}----------------------
// #include "SERVER/systems/systems_anticheat.inc"
#include "SERVER/systems/systems_anticheatv2"
#include "SERVER/systems/anticbug"
#include "SERVER/systems/antiaimbot"
#include "SERVER/systems/nocollision"
#include "SERVER/systems/antimamun"//Anti Maju Mundur
// #include "SERVER/systems/antiremcs_dan.inc"

#include "SERVER/toll/toll_functions"

// #include "SERVER/PlayerSpawn/spawn_functions.inc" Dimatikan sementara
#include "SERVER/jobs/Disnaker/disnaker_functions"

// #include "commands\boxing_funcs.inc"
#include "commands\management"
#include "commands\pengurus"
#include "commands\cmds_faction"
#include "commands\cmds_player"
#include "commands\cmds_admin"
#include "commands\earthquake"
#include "commands\NoClip"
//#include "commands\discord2"

#include "SERVER/carsteal/carsteal_functions"
#include "SERVER/PlayerStuff/player_toystd"
// #include "SERVER/mapping/mapping_server.inc"

// #include "SERVER/events/xmas.inc"
//#include "SERVER/events/events.inc"

#include "SERVER/showroom/showroom_functions"
#include "SERVER/PlayerStuff/player_actions"
#include "SERVER/PlayerStuff/player_asuransi"
#include "SERVER/PlayerStuff/player_fishingactivity"
#include "SERVER/damages/damagelog_functions"

#include "SERVER/FractionPlayer/Pedagang/menu_pedagang"

#include "SERVER/tags/core"
#include "SERVER/tags/cmd"
#include "SERVER/tags/funcs"
#include "SERVER/tags/impl"

// #include "commands\DISCORD"

#include "SERVER/PlayerCrafting/crafting_functions.inc"
// ----------------------------------------
#include "SERVER/streamer/streamer"
#include "SERVER/invoices/invoices"
#include "SERVER/blacklist/blacklist_functions"
#include "SERVER/timers/timer_task"
#include "SERVER/timers/timer_ptask_jail"
#include "SERVER/timers/timer_ptask_update"
#include "SERVER/playermarker/playermark"



forward OnGameModeInitEx();
forward OnGameModeExitEx();


main() 
{

}

stock GetValletPrice(modelid)
{
	new price;
	switch(modelid)
	{
		case 448, 461..463, 468, 521, 523, 586, 510: price = 1000;//motorcycle normal
		case 499, 609, 598, 524, 532, 578, 486, 406, 573, 455, 588, 403, 423, 414, 443, 515, 525: price = 1500;//truck
		case 429, 541, 415, 480, 562, 565, 434, 494, 502, 503, 411, 559, 561, 560, 506, 451, 558, 555, 477, 522: price = 2500;//sport vehicle
		case 581, 481, 509: price = 700;//bicycle
		default: price = 5000;
	}
	return price;
}

stock DatabaseConnection()
{
	g_SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);
	if (g_SQL == MYSQL_INVALID_HANDLE || mysql_errno(g_SQL) != 0)
	{
		print("Connection To MYSQL Failed! Server Shutting Down!");
		//SendRconCommand("exit");
	}
	else
	{
		print("Database successfully connected to MySQL.");
	}
	return 1;
}


stock OnFakespawnCheck(playerid) {

	if(AccountData[playerid][pID] == -1) {
		SendAdminMessage(X11_RED, "[AntiCheat]: "LIGHTGREY"Cheat detected on "YELLOW"%s (%d) "LIGHTGREY"(Fake Spawn)", GetName(playerid), playerid);
		SendClientMessageEx(playerid, X11_RED, "[AntiCheat]:"LIGHTGREY" Anda ditendang karena diduga Fake Spawn!");
		KickEx(playerid);
		return 1;
	}
	if(!AccountData[playerid][IsLoggedIn]) {
		SendAdminMessage(X11_RED, "[AntiCheat]: "LIGHTGREY"Cheat detected on "YELLOW"%s (%d) "LIGHTGREY"(Fake Spawn)", GetName(playerid), playerid);
		SendClientMessageEx(playerid, X11_RED, "[AntiCheat]:"LIGHTGREY" Anda ditendang karena diduga Fake Spawn!");
		KickEx(playerid);
		return 1;
	}

	if(!AccountData[playerid][pSpawned]) {
		SendAdminMessage(X11_RED, "[AntiCheat]: "LIGHTGREY"Cheat detected on "YELLOW"%s (%d) "LIGHTGREY"(Fake Spawn)", GetName(playerid), playerid);
		SendClientMessageEx(playerid, X11_RED, "[AntiCheat]:"LIGHTGREY" Anda ditendang karena diduga Fake Spawn!");
		KickEx(playerid);
		return 1;
	}
	return 0;
}

public OnGameModeInit()
{
	//#if defined MAKE_PELER
	//Profiler_Start();
	//#endif
	DatabaseConnection();
	ShowNameTags(false);
	EnableTirePopping(0);
	CreateTextDraw();
	// StreamerConfig();
	// LoadMap();
	//LoadWarungArea();
	//LoadArea();
	//LoadGangZone();
	LoadServerPickup();	
	ManualVehicleEngineAndLights();
	EnableStuntBonusForAll(0);
	AllowInteriorWeapons(1);
	DisableInteriorEnterExits();
	LimitPlayerMarkerRadius(15.0);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);

	SetGameModeText(sprintf("%s", TEXT_GAMEMODE));
	SendRconCommand(sprintf("weburl %s", TEXT_WEBURL));
	SendRconCommand(sprintf("language %s", TEXT_LANGUAGE));
	// SendRconCommand("hostname KARSA | SA-MP Indonesia");
	SendRconCommand("mapname San Andreas");
	BlockGarages(.text="Tutup");

	/* Load From Database */
	mysql_tquery(g_SQL, "SELECT * FROM `brankas_ems`", "LoadBrankasEms");
	mysql_tquery(g_SQL, "SELECT * FROM `brankas_bengkel`", "LoadBrankasBengkel");
	mysql_tquery(g_SQL, "SELECT * FROM `brankas_lounges`", "LoadBrankasLounges");
	mysql_tquery(g_SQL, "SELECT * FROM `buttons`", "LoadButtons");
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FROM `families`", "Families_Load");
	// mysql_tquery(g_SQL, "SELECT * FROM `families_garage`", "LoadFamiliesGarkot");
	//mysql_tquery(g_SQL, "SELECT * FROM `pintuotomatis`", "LoadPintu");
	mysql_tquery(g_SQL, "SELECT * FROM `house`", "LoadRumah");
	mysql_tquery(g_SQL, "SELECT * FROM `gate`", "LoadGate");
	mysql_tquery(g_SQL, "SELECT * FROM `actors`", "Actor_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `bike_rentals`", "Rental_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `public_garage`", "LoadPublicGarage");
	mysql_tquery(g_SQL, "SELECT * FROM `gudang`", "LoadGudang");
	mysql_tquery(g_SQL, "SELECT * FROM `warung`", "LoadWarung");
	mysql_tquery(g_SQL, "SELECT * FROM `pasar`", "LoadPasar");
	mysql_tquery(g_SQL, "SELECT * FROM `robbery`", "LoadDynamicRobbery");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");
	mysql_tquery(g_SQL, "SELECT * FROM `trash`", "LoadTrash");
	mysql_tquery(g_SQL, "SELECT * FROM `stuffs`", "LoadBrankasGoodside");
	mysql_tquery(g_SQL, "SELECT * FROM `ladang`", "LoadKanabis");
	mysql_tquery(g_SQL, "SELECT * FROM `icons`", "Icons_Load", "");
	mysql_tquery(g_SQL, "SELECT * FROM `label_fivem`", "LoadLabel");
	mysql_tquery(g_SQL, "SELECT * FROM `dynamic_rusun`", "Rusun_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `hunting`", "LoadDeer");
	mysql_tquery(g_SQL, "SELECT * FROM `weeds`", "Weed_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `voucher`", "LoadVoucher");
	mysql_tquery(g_SQL, "SELECT * FROM `objects`", "LoadDynamicObject");
	mysql_tquery(g_SQL, "SELECT * FROM `slotmachine`", "LoadSlotMachine");
	mysql_tquery(g_SQL, "SELECT * FROM `objecttext`", "ObjectText_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `uranium`", "Load_Uranium");
	mysql_tquery(g_SQL, "SELECT * FROM `workshop`", "Workshop_Load");
	mysql_tquery(g_SQL, "SELECT * FROM `tags` ORDER BY `tagId` ASC LIMIT "#MAX_DYNAMIC_TAGS";", "Tags_Load");
	mysql_tquery(g_SQL, "UPDATE `player_characters` SET `Char_LevelUp` = '400' WHERE `Char_LevelUp` > '500' AND `Char_Level` < '100'");

	for (new i; i < sizeof(ColorList); i++) {
        format(color_string, sizeof(color_string), "%s{%06x}%03d %s", color_string, ColorList[i] >>> 8, i, ((i+1) % 16 == 0) ? ("\n") : (""));
    }

    for (new i; i < sizeof(FontNames); i++) {
        format(object_font, sizeof(object_font), "%s%s\n", object_font, FontNames[i]);
    }
	
	for(new i = 0; i < sizeof(BarrierInfo);i ++)
	{
		new
		Float:X = BarrierInfo[i][brPos_X],
		Float:Y = BarrierInfo[i][brPos_Y];

		ShiftCords(0, X, Y, BarrierInfo[i][brPos_A]+90.0, 3.5);
		CreateDynamicObject(966,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z],0.00000000,0.00000000,BarrierInfo[i][brPos_A]);
		if(!BarrierInfo[i][brOpen])
		{
			gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,90.00000000,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.75,BARRIER_SPEED,0.0,90.0,BarrierInfo[i][brPos_A]+180);
		}
		else gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,20.00000000,BarrierInfo[i][brPos_A]+180);
	}

	/* Mprice Stuffs*/
	// OldTembagaPrice = TembagaPrice;
	// OldBesiPrice = BesiPrice;
	// OldEmasPrice = EmasPrice;
	// OldBerlianPrice = BerlianPrice;
	// OldMaterialPrice = MaterialPrice;
	// OldAlumuniumPrice = AlumuniumPrice;
	// OldKaretPrice = KaretPrice;
	// OldKacaPrice = KacaPrice;
	// OldBajaPrice = BajaPrice;
	// OldAyamKemasPrice = AyamKemasPrice;
	// OldSusuOlahPrice = SusuOlahPrice;
	// OldPakaianPrice = PakaianPrice;
	// OldKayuKemasPrice = KayuKemasPrice;
	// OldGasPrice = GasPrice;
	ChangeMPrice();
	
	SetTimer("WeatherRotator", 1800000, true);
	CallLocalFunction("OnGameModeInitEx", "");

	OpenVote = 0;
    VoteYes = 0;
    VoteNo = 0;
    VoteTime = 0;
    VoteText[0] = EOS;
	return 1;
} 

function UseItemInInventory(playerid, slot)
{
    new string[128];
    strunpack(string, InventoryData[playerid][slot][invItem]);

    if(slot == -1) // Memastikan ada item di slot tersebut
    {
        Warning(playerid, "Tidak ada item di slot tersebut!");
        return 1;
    }
    strunpack(string, InventoryData[playerid][slot][invItem]);

    if (InventoryData[playerid][slot][invQuantity] <= 0) // Pastikan quantity lebih besar dari 0
    {
        Warning(playerid, "Tidak ada item di slot tersebut!");
        return 1;
    }

    if (!PlayerHasItem(playerid, string)) // Pastikan quantity lebih besar dari 0
    {
        Warning(playerid, "Tidak ada item di slot tersebut!");
        return 1;
    }

    if(ItemCantUse(string))
    {
        Error(playerid, "Item tersebut tidak bisa digunakan!");
        return 1;
    }

    OnPlayerUseItem(playerid, slot, string); // Panggil fungsi untuk menggunakan item
    return 1;

}

forward OnPlayerKeyPress(playerid, key);
public OnPlayerKeyPress(playerid, key) {

	new player = playerid;

	if(AccountData[playerid][pSpawned]) {

		if(key == 80) { // Key P


			if(!PlayerHasItem(playerid, "Smartphone"))
			{
				return Error(playerid, "Anda tidak memiliki Smartphone!");
			}

			if(AccountData[playerid][pCuffed]) 
				return Error(playerid, "Anda sedang diborgol saat ini.");

			ShowingSmartphone(playerid);
		}
		else if(key == 113) { // Key F2

			if (AccountData[player][ActivityTime] != 0) 
				return Warning(playerid, "Tidak dapat membuka inventory saat actvitity berjalan!");

			if(AccountData[playerid][pCuffed]) 
				return Error(playerid, "Anda sedang diborgol saat ini.");

			PlayerPlaySound(playerid, 21000, 0.0, 0.0, 0.0);
			Inventory_Show(playerid);
		}
		else if(key == 90) {
			switch(GetPVarInt(playerid, "VoiceMode"))
			{
				case 1: // Normal
				{
					SetPVarInt(playerid, "VoiceMode", 2);
					PlayerTextDrawSetString(playerid, ATRP_VoiceTD[player][0], "VOICE: ~b~NORMAL");
					PlayerTextDrawShow(playerid, ATRP_VoiceTD[player][0]);
					CallRemoteFunction("UpdatePlayerVoiceDistance", "ddf", playerid, GetPVarInt(playerid, "VoiceMode"), 15.0);
				}
				case 2: // teriak
				{
					SetPVarInt(playerid, "VoiceMode", 3);
					PlayerTextDrawSetString(playerid, ATRP_VoiceTD[player][0], "VOICE: ~r~TERIAK");
					PlayerTextDrawShow(playerid, ATRP_VoiceTD[player][0]);
					CallRemoteFunction("UpdatePlayerVoiceDistance", "ddf", playerid, GetPVarInt(playerid, "VoiceMode"), 30.0);
				}
				case 3: // 
				{
					SetPVarInt(playerid, "VoiceMode", 1);
					PlayerTextDrawSetString(playerid, ATRP_VoiceTD[player][0], "VOICE: ~g~BERBISIK");
					PlayerTextDrawShow(playerid, ATRP_VoiceTD[player][0]);
					CallRemoteFunction("UpdatePlayerVoiceDistance", "ddf", playerid, GetPVarInt(playerid, "VoiceMode"), 8.0);
				}
			}
		}
		else if(key == 85) { // Key K

			new vehid = GetNearestVehicle(playerid), Float:X, Float:Y, Float:Z;
			if(vehid == INVALID_VEHICLE_ID) return 0;
			GetVehiclePos(vehid, X, Y, Z);

			new index = -1;
			if((index = Vehicle_Nearest2(playerid)) != -1) {
				if(PlayerVehicle[index][pVehOwnerID] != AccountData[playerid][pID]) return Error(playerid, "Kendaraan ini bukan milik anda!");
				
				PlayerVehicle[index][pVehLocked] = !(PlayerVehicle[index][pVehLocked]);

				PlayerPlayNearbySound(playerid, SOUND_LOCK_CAR_DOOR);
				LockVehicle(PlayerVehicle[index][pVehPhysic], PlayerVehicle[index][pVehLocked]);
				ToggleVehicleLights(PlayerVehicle[index][pVehPhysic], PlayerVehicle[index][pVehLocked]);
				// ShowPlayerFooter(playerid, sprintf("~w~%s %s", GetVehicleName(PlayerVehicle[index][pVehPhysic]), PlayerVehicle[index][pVehLocked] ? ("~r~Terkunci") : ("~g~Terbuka")), 4000);
				GameTextForPlayer(playerid, sprintf("~y~%s~n~%s", GetVehicleName(PlayerVehicle[index][pVehPhysic]), PlayerVehicle[index][pVehLocked] ? ("~r~Terkunci") : ("~g~Terbuka")), 4000, 4);
				if(!IsPlayerInAnyVehicle(player)) {
					SetPlayerFace(playerid, X, Y);
					ApplyAnimationEx(playerid, "ped", "gang_gunstand", 4.1, 0, 0, 0, 0, 500, 0);
				}
			}


			if(AccountData[playerid][pJobVehicle] != 0)
			{
				if (vehid == JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle])
				{
					JobVehicle[AccountData[playerid][pJobVehicle]][Locked] = !(JobVehicle[AccountData[playerid][pJobVehicle]][Locked]);

					PlayerPlayNearbySound(playerid, SOUND_LOCK_CAR_DOOR);
					LockVehicle(JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle], JobVehicle[AccountData[playerid][pJobVehicle]][Locked]);
					ToggleVehicleLights(JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle], JobVehicle[AccountData[playerid][pJobVehicle]][Locked]);
					// ShowPlayerFooter(playerid, sprintf("~w~%s %s", GetVehicleName(JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle]), JobVehicle[AccountData[playerid][pJobVehicle]][Locked] ? ("~r~Terkunci") : ("~g~Terbuka")), 4000);
					GameTextForPlayer(playerid, sprintf("~y~%s~n~%s", GetVehicleName(JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle]), JobVehicle[AccountData[playerid][pJobVehicle]][Locked] ? ("~r~Terkunci") : ("~g~Terbuka")), 4000, 4);
					if(!IsPlayerInAnyVehicle(player)) {
						ApplyAnimationEx(playerid, "ped", "gang_gunstand", 4.1, 0, 0, 0, 0, 500, 0);
					}
				}
				return 1;
			}
		}
		else if(key == 82) // Key R
		{
			if (!PlayerHasItem(player, "Radio")) return Error(playerid, "Anda tidak memiliki Radio!");
			if (IsPlayerInWater(player)) return Error(playerid, "Anda tidak dapat membuka Radio saat berada di air!");

			switch(GetPVarInt(player, "RadioValue"))
			{
				case false:
				{
					SetPVarInt(player, "RadioValue", true);
					SendRPMeAboveHead(player, "Membuka radio miliknya", X11_PLUM1);
					if (!IsPlayerInAnyVehicle(player))
					{
						ApplyAnimationEx(player, "ped", "Jetpack_Idle", 4.1, 0, 0, 0, 1, 0, 1);

						if(AccountData[player][pUsingOutfit] == -1) {
							SetPlayerAttachedObject(player, 9, 19942, 5, 0.043000, 0.022999, -0.006000, -112.000022, -34.900020, -8.500002, 1.000000, 1.000000, 1.000000);
						}
					}
					RadioTextdrawToggle(player, true);
					SelectTextDraw(player, COLOR_CLIENT);
				}
				case true:
				{
					SetPVarInt(player, "RadioValue", false);
					SendRPMeAboveHead(player, "Menutup Radio miliknya.", X11_PLUM1);
					if(!IsPlayerInAnyVehicle(player))
					{
						ClearAnimations(player);
						ApplyAnimation(player, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
						SetPlayerSpecialAction(player, SPECIAL_ACTION_NONE);
					}

					if(AccountData[playerid][pUsingOutfit] == -1) {
						RemovePlayerAttachedObject(player, 9);
					}
					RadioTextdrawToggle(player, false);
					CancelSelectTextDraw(player);
				}
			}
		}
		else if(key == 74) // key J
		{
			if(GetPVarInt(playerid, "DurringGym"))
				return WarningMsg(playerid, "Anda sedang melakukan Aktivitas GYM!");

			if(!AccountData[playerid][pFreeze])
			{
				ClearAnimations(playerid, 1);
				StopLoopingAnim(playerid);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				TogglePlayerControllable(playerid, 1);
				if(AccountData[playerid][pUsingOutfit] == -1)
					RemovePlayerAttachedObject(playerid, 9);
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);

				AccountData[playerid][pLoopAnim] = false;
			}
		}
		else if(key == 49) // Angka 1
		{
			UseItemInInventory(player, 0);
		}
		else if(key == 50) // Angka 2
		{
			if(!IsPlayerInAnyVehicle(player)) {
				UseItemInInventory(player, 1);
			}
		}
		else if(key == 51) // Angka 3
		{
			UseItemInInventory(player, 2);
		}
		else if(key == 52) // Angka 4
		{
			UseItemInInventory(player, 3);
		}
		else if(key == 88) { // Key X
			if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
				ApplyAnimationEx(playerid, "ROB_BANK", "SHP_HandsUp_Scr", 4.1, 0, 0, 0, 1, 0, 1);
			}
		}
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	#if defined DEBUG_MODE
	    printf("[debug] OnPlayerInteriorChange(PID : %d New-Int : %d Old-Int : %d)", playerid, newinteriorid, oldinteriorid);
	#endif

	CancelEdit(playerid);

	foreach(new i : Player) if (AccountData[i][pSpec] != INVALID_PLAYER_ID && AccountData[i][pSpec] == playerid)
	{
		SetPlayerInterior(i, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
	}

	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if (!AccountData[playerid][IsLoggedIn])
    {
		GameTextForPlayer(playerid, "~r~Stay in your world bastard!", 2000, 4);
		SendClientMessageEx(playerid, X11_RED, "[AntiCheat]:"LIGHTGREY" Anda ditendang karena diduga Fake Spawn!");
        KickEx(playerid);
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(SQL_IsCharacterLogged(playerid) && AccountData[playerid][pAdmin] > 0)
	{
		if(!IsPlayerConnected(clickedplayerid)) return 0;
		if(clickedplayerid == playerid) return 0;

		new title[127];
		format(title, sizeof(title), ""JAVA"KARSA "WHITE"- %s(%d)", ReturnName(clickedplayerid), clickedplayerid);
		ShowPlayerDialog(playerid, DIALOG_CLICKPLAYER, DIALOG_STYLE_LIST, title, 
		""JAVA"Menu Admin\n\
		\nSpectator Pemain\
		\n"GRAY"Tarik Pemain\
		\nTeleport Ke Pemain\
		\n"GRAY"Banned Pemain\
		\nKick Pemain\
		\n"GRAY"Stats Pemain", "Pilih", "Batal");
		ClickPlayerID[playerid] = clickedplayerid;
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetCameraData(playerid);

	if(!AccountData[playerid][IsLoggedIn])
	{		
		new query[268];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `playerucp` WHERE `ucp` = '%s' LIMIT 1", AccountData[playerid][pUCP]);
		mysql_pquery(g_SQL, query, "CheckPlayerUCP", "id", playerid, g_RaceCheck[playerid]);
		SetPlayerColor(playerid, X11_GRAY);
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
    new weaponid = GetPlayerWeaponEx(playerid);
    if(AccountData[playerid][pFaction] == 0 && AccountData[playerid][pFamily] == -1 && AccountData[playerid][pAdmin] == 0)
    {
        if(GetPVarInt(playerid, "BypassSenjataAdmin") == 1) return 1;

        if(weaponid == WEAPON_COLT45 || weaponid == WEAPON_SILENCED || weaponid == WEAPON_DEAGLE || weaponid == WEAPON_SHOTGUN || weaponid == WEAPON_SAWEDOFF || weaponid == WEAPON_SHOTGSPA || weaponid == WEAPON_UZI || weaponid == WEAPON_MP5 || weaponid == WEAPON_AK47 || weaponid == WEAPON_M4 || weaponid == WEAPON_TEC9 || weaponid == WEAPON_RIFLE || weaponid == WEAPON_SNIPER || weaponid == WEAPON_MINIGUN)
        {
            ResetWeapon(playerid, weaponid);
            SendClientMessageEx(playerid, -1, ""YELLOW"Anda ditendang karna memegang senjata");
            SendStaffMessage(X11_ARWIN, "[ANTICHEAT] "YELLOW"%s "WHITE"telah ditendang karena memegang senjata!", AccountData[playerid][pName]);
            KickEx(playerid);
        }
    }
    return 1;
}

public OnGameModeExit()
{
	#if defined DEBUG_MODE
	    printf("[debug] OnGameModeExit()");
	#endif

    SaveAll();
	
	foreach(new playerid : Player)
		TerminateConnection(playerid);

	CallLocalFunction("OnGameModeExitEx", "");
	mysql_close(g_SQL);
	/*#if defined MAKE_PELER
	Profiler_Dump();
	Profiler_Stop();
	#endif*/
	return 1;
}

forward OnPlayerCarJacking(playerid);
public OnPlayerCarJacking(playerid)
{
	new Float:playerPos[3];
	GetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2]);
	AccountData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);
	
	SetPlayerPos(playerid, playerPos[0], playerPos[1], playerPos[2] + 9.0);
	TogglePlayerControllable(playerid, false);
	GameTextForPlayer(playerid, "No Jacking!", 5500, 4);
	SetPlayerVirtualWorld(playerid, (playerid+1));
	SetTimerEx("OnPlayerCarJackingUpdate", 5500, false, "d", playerid);
	return 1;	
}

forward OnPlayerCarJackingUpdate(playerid);
public OnPlayerCarJackingUpdate(playerid)
{
	TogglePlayerControllable(playerid, true);
	SetPlayerVirtualWorld(playerid, AccountData[playerid][pWorld]);
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	OnFakespawnCheck(playerid);

	if(!ispassenger)
	{
		new driverid = GetVehicleDriver(vehicleid);
		if(driverid != INVALID_PLAYER_ID && IsPlayerInVehicle(driverid, vehicleid) && !IsVehicleEmpty(vehicleid) && IsPlayerChangeSeat[playerid] == false)
		{
			SetTimerEx("OnPlayerCarJacking", 250, false, "d", playerid);
		}
		new vehicle_near = GetNearestVehicle(playerid);
		if((vehicle_near = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
		{
			if(PlayerVehicle[vehicle_near][pVehFaction] == FACTION_POLISI)
			{
				if(AccountData[playerid][pFaction] != FACTION_POLISI && AccountData[playerid][pFaction] != FACTION_BENGKEL)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					ErrorMsg(playerid, "Kendaraan ini milik faction Polisi!");
				}
			}
			else if(PlayerVehicle[vehicle_near][pVehFaction] == FACTION_PEMERINTAH)
			{
				if(AccountData[playerid][pFaction] != FACTION_PEMERINTAH && AccountData[playerid][pFaction] != FACTION_BENGKEL)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					ErrorMsg(playerid, "Kendaraan ini milik faction Pemerintah!");
				}
			}
			else if(PlayerVehicle[vehicle_near][pVehFaction] == FACTION_EMS)
			{
				if(AccountData[playerid][pFaction] != FACTION_EMS && AccountData[playerid][pFaction] != FACTION_BENGKEL)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					ErrorMsg(playerid, "Kendaraan ini milik faction EMS!");
				}
			}
			else if(PlayerVehicle[vehicle_near][pVehFaction] == FACTION_TRANS)
			{
				if(AccountData[playerid][pFaction] != FACTION_TRANS && AccountData[playerid][pFaction] != FACTION_BENGKEL && AccountData[playerid][pFaction] != FACTION_POLISI)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					ErrorMsg(playerid, "Kendaraan ini milik faction Transportasi!");
				}
			}
			else if(PlayerVehicle[vehicle_near][pVehFaction] == FACTION_BENGKEL)
			{
				if(AccountData[playerid][pFaction] != FACTION_POLISI && AccountData[playerid][pFaction] != FACTION_BENGKEL)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					ErrorMsg(playerid, "Kendaraan ini milik faction Bengkel!");
				}
			}
			else if(PlayerVehicle[vehicle_near][pVehFaction] == FACTION_PEDAGANG)
			{
				if(AccountData[playerid][pFaction] != FACTION_PEDAGANG && AccountData[playerid][pFaction] != FACTION_BENGKEL)
				{
					RemovePlayerFromVehicle(playerid);
					new Float:slx, Float:sly, Float:slz;
					GetPlayerPos(playerid, slx, sly, slz);
					SetPlayerPos(playerid, slx, sly, slz);
					ErrorMsg(playerid, "Kendaraan ini milik faction Pedagang!");
				}
			}
		}
	}
	return 1;
}

forward TrackSuspect(suspectid, policeid);
public TrackSuspect(suspectid, policeid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(suspectid, x, y, z);

	SetPlayerRaceCheckpoint(policeid, 1, x, y, z, 0.0, 0.0, 0.0, 5.0);
	Info(policeid, "Tracking Suspect Updated!");
	pMapCP[policeid] = true;
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(!AccountData[playerid][IsLoggedIn] || !AccountData[playerid][pSpawned])
		return 0;

	if(AccountData[playerid][pAdmin] > 0 && AccountData[playerid][pAdminDuty])
	{
		if(strlen(text) > 64)
		{
			SendNearbyMessage(playerid, 15.0, -1, "Admin "RED"%s"WHITE": (( %.64s...", AccountData[playerid][pAdminname], text);
			SendNearbyMessage(playerid, 15.0, -1, "...%s ))", text[64]);
		}
		else 
		{
			SendNearbyMessage(playerid, 15.0, -1, "Admin "RED"%s"WHITE": (( %s ))", AccountData[playerid][pAdminname], text);
		}
	}
	return 0;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if (result != -1 && !AccountData[playerid][IsLoggedIn])
	{
		SendClientMessage(playerid, -1, ""RED"[AntiCheat]"ARWIN1" Anda ditendang dari server karena menggunakan CMD dalam keadaan tidak login!");
		return KickEx(playerid);
	}
	
    if (result == -1)
    {
		if(AccountData[playerid][pStyleNotif] == 1) //TD
		{
			ErrorMsg(playerid, sprintf("Perintah ~y~'/%s'~w~ tidak diketahui, ~y~'/help'~w~ untuk info lanjut!", cmd));
		}
		else
		{
			ErrorMsg(playerid, sprintf("Perintah "YELLOW"'/%s'"WHITE" tidak diketahui, "YELLOW"'/help'"WHITE" untuk info lanjut!", cmd));
		}
		return 0;
    }
	return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	
	g_RaceCheck[playerid] ++;
	ResetVariables(playerid);
	Player_ToggleTelportAntiCheat(playerid, false);
	Player_ToggleAntiHealthHack(playerid, false);
	Player_ToggleDisableAntiCheat(playerid, false);
	EnableAntiCheatForPlayer(playerid, 11, true);
	EnableAntiCheatForPlayer(playerid, 19, true);
	
	ReturnIP(playerid);
	CreatePlayerTextDraws(playerid);
	OnLoadMixerProperty(playerid);
	PlayRandomSong(playerid);
	
	//PlayAudioStreamForPlayer(playerid, "https://j.top4top.io/m_3353zfgvc1.mp3", 0.0, 0.0, 0.0, 50.0, 0);

	if(g_RestartServer || g_AsuransiTime) {
		TextDrawShowForPlayer(playerid, gServerTextdraws[0]);
	}

	GetPlayerName(playerid, AccountData[playerid][pUCP], MAX_PLAYER_NAME + 1);

    if(AccountData[playerid][pHead] < 0) return AccountData[playerid][pHead] = 20;
    if(AccountData[playerid][pPerut] < 0) return AccountData[playerid][pPerut] = 20;
    if(AccountData[playerid][pRFoot] < 0) return AccountData[playerid][pRFoot] = 20;
    if(AccountData[playerid][pLFoot] < 0) return AccountData[playerid][pLFoot] = 20;
    if(AccountData[playerid][pLHand] < 0) return AccountData[playerid][pLHand] = 20;
    if(AccountData[playerid][pRHand] < 0) return AccountData[playerid][pRHand] = 20;
	
	PantaiArea[playerid] = CreateDynamicRectangle(345.3125, -2094.787811279297, 415.3125, -2007.7878112792969);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	/*if(AccountData[playerid][LoginTimer])//Matikan Login Timer
	{
		KillTimer(AccountData[playerid][LoginTimer]);
		AccountData[playerid][LoginTimer] = 0;
	}*/

	if(jobs::mixer[playerid][mixerTimer]) {
		KillTimer(jobs::mixer[playerid][mixerTimer]);
	}
	KillTimer(AccountData[playerid][DokterLokalTimer]);
	KillTimer(AccountData[playerid][pDutyTimer]);
	RemoveDrag(playerid);
	CheckDrag(playerid);
	Report_Clear(playerid);
	Ask_Clear(playerid);

	g_RaceCheck[playerid] ++;
	
	if (AccountData[playerid][IsLoggedIn])
	{
		UpdatePlayerData(playerid);
		UnloadPlayerVehicle(playerid);

		if (AccountData[playerid][pJobVehicle] != 0)
		{
			DestroyJobVehicle(playerid);
			AccountData[playerid][pJobVehicle] = 0;
		}
	}

	if(IsValidDynamic3DTextLabel(AccountData[playerid][pAdoTag])) DestroyDynamic3DTextLabel(AccountData[playerid][pAdoTag]);
	if(IsValidDynamic3DTextLabel(AccountData[playerid][pMaskLabel])) DestroyDynamic3DTextLabel(AccountData[playerid][pMaskLabel]);

	if(IsValidDynamic3DTextLabel(AccountData[playerid][NewbieLabel])) DestroyDynamic3DTextLabel(AccountData[playerid][NewbieLabel]);

    if(AccountData[playerid][pAdminDuty] == 1)
	if(IsValidDynamic3DTextLabel(AccountData[playerid][pLabelDuty]))
		DestroyDynamic3DTextLabel(AccountData[playerid][pLabelDuty]);

	new reasontext[526], frmxt[255], Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);

	switch(reason)
	{
	    case 0: format(reasontext, sizeof(reasontext), "Timeout/Crash");
	    case 1: format(reasontext, sizeof(reasontext), "Quit");
		case 2: format(reasontext, sizeof(reasontext), "Kicked/Banned");
	}

	if(DestroyDynamic3DTextLabel(labelDisconnect[playerid])) 
		labelDisconnect[playerid] = STREAMER_TAG_3D_TEXT_LABEL: INVALID_STREAMER_ID;

	format(frmxt, sizeof(frmxt), "Player ["YELLOW"%d"WHITE"]"YELLOW" %s | %s"WHITE" Telah keluar dari server.\nReason: "RED"%s", playerid, AccountData[playerid][pName], AccountData[playerid][pUCP], reasontext);
	labelDisconnect[playerid] = CreateDynamic3DTextLabel(frmxt, -1, pX, pY, pZ, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0, -1, 0);
	labelDisconnectTimer[playerid] = SetTimerEx("DestroyLabelOut", 30000, false, "i", playerid);
	
	if(AccountData[playerid][phoneDurringConversation])
	{
		CutCallingLine(playerid);
	}
	TerminateConnection(playerid);
	AccountData[playerid][pDutyEms] = 0;
	AccountData[playerid][pFaction] = 0;
	return 1;
}	

public OnPlayerSpawn(playerid)
{
	if(AccountData[playerid][pGender] == 0)
	{
		TogglePlayerControllable(playerid,0);
		SetPlayerHealth(playerid, 100.0);
		SetPlayerArmour(playerid, 0.0);
		SetPlayerCameraPos(playerid, 584.769, -2183.039, 131.617);
		SetPlayerCameraLookAt(playerid, 582.755, -2178.958, 129.546);
		InterpolateCameraPos(playerid, 584.769, -2183.039, 131.617, 584.769, -2183.039, 131.617, 20000, CAMERA_MOVE);
		SetPlayerVirtualWorld(playerid, 3);
		ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, ""JAVA"KARSA "WHITE"- Tanggal Lahir", "Mohon masukkan tanggal lahir sesuai format hh/bb/tttt cth: (25/09/2001)", "Input", "");
	}
	else
	{
		if(!AccountData[playerid][pSpawned])
		{
			AccountData[playerid][pSpawned] = 1;
			SetCameraBehindPlayer(playerid);
			Streamer_ToggleIdleUpdate(playerid, true);
			StopAudioStreamForPlayer(playerid);
			
			GivePlayerMoney(playerid, AccountData[playerid][pMoney]);
			SetPlayerScore(playerid, AccountData[playerid][pLevel]);
			SetPlayerHealth(playerid, AccountData[playerid][pHealth]);
			// SetPlayerArmour(playerid, AccountData[playerid][pArmour]);
			SetPlayerInterior(playerid, AccountData[playerid][pInt]);
			SetPlayerVirtualWorld(playerid, AccountData[playerid][pWorld]);
			PreloadAnimations(playerid);

			TogglePlayerControllable(playerid, false);
			static Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			ShowPlayerFooter(playerid, "~y~MEMUAT OBJECT", 7000);
			AccountData[playerid][pFreeze] = 1;
			AccountData[playerid][pFreezeTimer] = SetTimerEx("SetPlayerToUnfreeze", 7000, false, "iffff", playerid, X, Y, Z); //defer SetPlayerToUnfreeze[time](playerid);
			Player_ToggleTelportAntiCheat(playerid, true);

			SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 999);

			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 999);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0);

			SendClientMessageEx(playerid, -1, ""BLUEJEGE"SERVER: "WHITE"Selamat datang "YELLOW"%s.", ReturnName(playerid));
			SendClientMessageEx(playerid, -1, ""BLUEJEGE"SERVER: "WHITE"Today is "YELLOW"%s", ReturnTime());
			SendClientMessageEx(playerid, -1, ""BLUEJEGE"SERVER: "WHITE"Server memerlukan waktu "YELLOW"%d milisecond"WHITE" untuk memuat char anda.", GetPlayerPing(playerid));
			SendClientMessage(playerid, -1, ""LIGHTSKYBLUE"NOTE:"WHITE" Jika anda punya pertanyaan gunakan "RED"/ask"WHITE", untuk keperluan lainnya anda dapat menggunakan "RED"/help");
			SendClientMessage(playerid, -1, ""LIGHTSKYBLUE"NOTE:"WHITE" Discord kita yaitu: "JAVA"discord.gg/KARSA");
			SendClientMessage(playerid, -1, ""LIGHTSKYBLUE"MOTD: "WHITE"Selamat bermain dan memulai cerita di "JAVA"KARSA");

			
			new vQuery[300];
			mysql_format(g_SQL, vQuery, sizeof(vQuery), "SELECT * FROM `player_vehicles` WHERE `PVeh_OwnerID` = '%d' ORDER BY `id` ASC", AccountData[playerid][pID]);
			mysql_tquery(g_SQL, vQuery, "Vehicle_Load", "d", playerid);

			if(VoucherData[0][voucherExists] && AccountData[playerid][pKompensasi] < 1)
			{
				SendClientMessageEx(playerid, -1, "[i] Anda memiliki kompensasi yang belum di claim! gunakan "YELLOW"'/klaimkompensasi'"WHITE" untuk mengambil kompensasi");
			}
			if(AccountData[playerid][pDutyPD] || AccountData[playerid][pDutyPemerintah] || AccountData[playerid][pDutyEms] 
				|| AccountData[playerid][pDutyBengkel] || AccountData[playerid][pDutyTrans] || AccountData[playerid][pDutyPedagang])
			{
				AccountData[playerid][pDutyTimer] = SetTimerEx("FactDutyHour", 1000, true, "d", playerid);
			}
		}

		if(IsPlayerInEvent(playerid))
		 	return 0;
		
		Streamer_ToggleIdleUpdate(playerid, true);
		PreloadAnimations(playerid);
		if(AccountData[playerid][pUsingUniform])
		{
			SetPlayerSkin(playerid, AccountData[playerid][pUniform]);
		}
		else
		{
			SetPlayerSkin(playerid, AccountData[playerid][pSkin]);
		}

		if(AccountData[playerid][pInjured] == 1 && AccountData[playerid][pInjuredTime] != 0)
		{
			TogglePlayerControllable(playerid, false);
			SetPlayerPos(playerid, AccountData[playerid][pPosX], AccountData[playerid][pPosY], AccountData[playerid][pPosZ]);
			SetPlayerFacingAngle(playerid, AccountData[playerid][pPosA]);
			SetPlayerInterior(playerid, AccountData[playerid][pInt]);
			SetPlayerVirtualWorld(playerid, AccountData[playerid][pWorld]);
		}

		if(AccountData[playerid][pAdminDuty] > 0)
		{
			SetPlayerColor(playerid, X11_DARKRED);
		}
		SetTimerEx("TimersSpawn", 5000, false, "d", playerid);
	}
	return 1;
}

forward TimersSpawn(playerid);
public TimersSpawn(playerid)
{
    if(!AccountData[playerid][pSpawned])
        return 0;

    if(AccountData[playerid][pJail] > 0)
    {
        SpawnPlayerInJail(playerid);
    }
    
    if(AccountData[playerid][pArrestTime] > 0)
    {
        SetPlayerArrest(playerid, AccountData[playerid][pArrest]);
    }
    
    //GangZoneShowForPlayer(playerid, GangZoneData[gzSafezone], 0xFFB6C1EE);
    TogglePlayerControllable(playerid, 1);
    SetPlayerInterior(playerid, AccountData[playerid][pInt]);
    SetPlayerVirtualWorld(playerid, AccountData[playerid][pWorld]);
    AttachPlayerToys(playerid);
    SetWeapons(playerid);
    SetPlayerArmour(playerid, AccountData[playerid][pArmour]);

    if(AccountData[playerid][pLevel] < 5)
    {
        AccountData[playerid][NewbieLabel] = CreateDynamic3DTextLabel("[Warga Baru]", -1, 0, 0, -20, 10.0, playerid);
        Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, AccountData[playerid][NewbieLabel], E_STREAMER_ATTACH_OFFSET_Z, 0.30);
    }

    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(!AccountData[playerid][pSpawned])
		return 0;

	foreach(new i : Player) if (IsPlayerConnected(i))
	{
		if(AccountData[i][pAdmin] > 0 && AccountData[i][pTheStars] > 0)
		{
			SendDeathMessageToPlayer(i, killerid, playerid, reason);
			return 1;
		}
	}
	new reasontext[596];
	switch(reason)
	{
		case 0: reasontext = "Tangan Kosong";
		case 1: reasontext = "Brass Knuckles";
		case 2: reasontext = "Golf Club";
		case 3: reasontext = "Nite Stick";
		case 4: reasontext = "Knife";
		case 5: reasontext = "Basebal Bat";
		case 6: reasontext = "Shovel";
		case 7: reasontext = "Pool Cue";
		case 8: reasontext = "Katana";
		case 9: reasontext = "Chain Shaw";
		case 14: reasontext = "Cane";
		case 18: reasontext = "Molotov";
		case 22: reasontext = "Colt 45";
		case 23: reasontext = "SLC";
		case 24: reasontext = "Desert Eagle";
		case 25: reasontext = "Shotgun";
		case 26: reasontext = "Sawnoff Shotgun";
		case 27: reasontext = "Combat Shotgun";
		case 28: reasontext = "Micro SMG/Uzi";
		case 29: reasontext = "MP5";
		case 30: reasontext = "AK-47";
		case 31: reasontext = "M4";
		case 32: reasontext = "Tec-9";
		case 33: reasontext = "Coutry Rifle";
		case 38: reasontext = "Mini Gun";
		case 49: reasontext = "Tertabrak Kendaraan";
		case 50: reasontext = "Helicopter Blades";
		case 51: reasontext = "Explode";
		case 53: reasontext = "Drowned";
		case 54: reasontext = "Splat";
		case 255: reasontext = "Suicide";
	}

	SetPlayerArmedWeapon(playerid, 0);
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ )
{
	new weaponid = EditingWeapon[playerid];
	if(response)
	{
		if(weaponid)
		{
			new enum_index = weaponid - 22, weaponname[18], string[340];
 
            GetWeaponName(weaponid, weaponname, sizeof(weaponname));
           
            WeaponSettings[playerid][enum_index][Position][0] = fOffsetX;
            WeaponSettings[playerid][enum_index][Position][1] = fOffsetY;
            WeaponSettings[playerid][enum_index][Position][2] = fOffsetZ;
            WeaponSettings[playerid][enum_index][Position][3] = fRotX;
            WeaponSettings[playerid][enum_index][Position][4] = fRotY;
            WeaponSettings[playerid][enum_index][Position][5] = fRotZ;
 
			if(AccountData[playerid][pUsingOutfit] == -1) {
				RemovePlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid));
				SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
			}
			SuccesMsg(playerid, sprintf("Berhasil merubah posisi letak %s", weaponname));
           
			EditingWeapon[playerid] = 0;
            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO weaponsettings (Owner, WeaponID, PosX, PosY, PosZ, RotX, RotY, RotZ) VALUES ('%d', %d, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f) ON DUPLICATE KEY UPDATE PosX = VALUES(PosX), PosY = VALUES(PosY), PosZ = VALUES(PosZ), RotX = VALUES(RotX), RotY = VALUES(RotY), RotZ = VALUES(RotZ)", AccountData[playerid][pID], weaponid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            mysql_tquery(g_SQL, string);
		}

		if(AccountData[playerid][toySelected] != -1)
		{
			new id = AccountData[playerid][toySelected];
			pToys[playerid][id][toy_x] = fOffsetX;
			pToys[playerid][id][toy_y] = fOffsetY;
			pToys[playerid][id][toy_z] = fOffsetZ;
			pToys[playerid][id][toy_rx] = fRotX;
			pToys[playerid][id][toy_ry] = fRotY;
			pToys[playerid][id][toy_rz] = fRotZ;
			pToys[playerid][id][toy_sx] = fScaleX;
			pToys[playerid][id][toy_sy] = fScaleY;
			pToys[playerid][id][toy_sz] = fScaleZ;
			
			MySQL_SavePlayerToys(playerid);
			SuccesMsg(playerid, "Berhasil menyimpan kordinat baru.");
			AccountData[playerid][toySelected] = -1;
		}
	}
	else
	{
		if(EditingWeapon[playerid])
		{
			new enum_index = weaponid - 22;
			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, GetWeaponObjectSlot(weaponid), GetWeaponModel(weaponid), WeaponSettings[playerid][enum_index][Bone], fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, 1.0, 1.0, 1.0);
			
			EditingWeapon[playerid] = 0;
		}

		if(AccountData[playerid][toySelected] != -1)
		{
			new id = AccountData[playerid][toySelected];

			if(AccountData[playerid][pUsingOutfit] == -1) {
				SetPlayerAttachedObject(playerid,
					id,
					modelid,
					boneid,
					pToys[playerid][id][toy_x],
					pToys[playerid][id][toy_y],
					pToys[playerid][id][toy_z],
					pToys[playerid][id][toy_rx],
					pToys[playerid][id][toy_ry],
					pToys[playerid][id][toy_rz],
					pToys[playerid][id][toy_sx],
					pToys[playerid][id][toy_sy],
					pToys[playerid][id][toy_sz]);
			}
			AccountData[playerid][toySelected] = -1;
		}
	}
	SetPVarInt(playerid, "UpdatedToy", 1);
	return 1;
}


public OnPlayerEditDynamicObject(playerid, STREAMER_TAG_OBJECT: objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(AccountData[playerid][piEditID] != -1 && Iter_Contains(JumlahPintu, AccountData[playerid][piEditID]))
	{
		new id = AccountData[playerid][piEditID];
		if(response == EDIT_RESPONSE_UPDATE)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{
			SetDynamicObjectPos(objectid, piPosX[playerid], piPosY[playerid], piPosZ[playerid]);
			SetDynamicObjectRot(objectid, piRotX[playerid], piRotY[playerid], piRotZ[playerid]);
			piPosX[playerid] = 0; piPosY[playerid] = 0; piPosZ[playerid] = 0;
			piRotX[playerid] = 0; piRotY[playerid] = 0; piRotZ[playerid] = 0;
			SendClientMessageEx(playerid, -1, " You have canceled editing pintu ID %d.", id);
			Pintu_Save(id);
		}
		else if(response == EDIT_RESPONSE_FINAL)
		{
			SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			if(AccountData[playerid][piEdit] == 1)
			{
				piData[id][pCX] = x;
				piData[id][pCY] = y;
				piData[id][pCZ] = z;
				piData[id][pCRX] = rx;
				piData[id][pCRY] = ry;
				piData[id][pCRZ] = rz;
                
				AccountData[playerid][piEditID] = -1;
				AccountData[playerid][piEdit] = 0;
				SendClientMessageEx(playerid, -1, " You have finished editing pintu ID %d's closing position.", id);
				DestroyDynamicArea(piData[id][pArea]);
				piData[id][pArea] = CreateDynamicSphere(piData[id][pCX], piData[id][pCY], piData[id][pCZ], piData[id][pRange]);
				Pintu_Save(id);
			}
			else if(AccountData[playerid][piEdit] == 2)
			{
				piData[id][pOX] = x;
				piData[id][pOY] = y;
				piData[id][pOZ] = z;
				piData[id][pORX] = rx;
				piData[id][pORY] = ry;
				piData[id][pORZ] = rz;
				
				AccountData[playerid][piEditID] = -1;
				AccountData[playerid][piEdit] = 0;
				SendClientMessageEx(playerid, -1, " You have finished editing pintu ID %d's opening position.", id);
				Pintu_Save(id);
			}
		}
	}
	if(AccountData[playerid][EditingDeerID] != -1 && Iter_Contains(Hunt, AccountData[playerid][EditingDeerID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = AccountData[playerid][EditingDeerID];
	        HuntData[etid][DeerPOS][0] = x;
	        HuntData[etid][DeerPOS][1] = y;
	        HuntData[etid][DeerPOS][2] = z;
	        HuntData[etid][DeerROT][0] = rx;
	        HuntData[etid][DeerROT][1] = ry;
	        HuntData[etid][DeerROT][2] = rz;

	        SetDynamicObjectPos(objectid, HuntData[etid][DeerPOS][0], HuntData[etid][DeerPOS][1], HuntData[etid][DeerPOS][2]);
	        SetDynamicObjectRot(objectid, HuntData[etid][DeerROT][0], HuntData[etid][DeerROT][1], HuntData[etid][DeerROT][2]);

			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HuntData[etid][DeerLabel], E_STREAMER_X, HuntData[etid][DeerPOS][0]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HuntData[etid][DeerLabel], E_STREAMER_Y, HuntData[etid][DeerPOS][1]);
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, HuntData[etid][DeerLabel], E_STREAMER_Z, HuntData[etid][DeerPOS][2] + 1.1);

		    HuntSave(etid);
	        AccountData[playerid][EditingDeerID] = -1;
	    }
	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = AccountData[playerid][EditingDeerID];
	        SetDynamicObjectPos(objectid, HuntData[etid][DeerPOS][0], HuntData[etid][DeerPOS][1], HuntData[etid][DeerPOS][2]);
	        SetDynamicObjectRot(objectid, HuntData[etid][DeerROT][0], HuntData[etid][DeerROT][1], HuntData[etid][DeerROT][2]);
	        AccountData[playerid][EditingDeerID] = -1;
	    }
	}
	else if(AccountData[playerid][EditingLADANGID] != -1 && Iter_Contains(Ladang, AccountData[playerid][EditingLADANGID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = AccountData[playerid][EditingLADANGID];
	        LadangData[etid][kanabisX] = x;
	        LadangData[etid][kanabisY] = y;
	        LadangData[etid][kanabisZ] = z;
	        LadangData[etid][kanabisRX] = rx;
	        LadangData[etid][kanabisRY] = ry;
	        LadangData[etid][kanabisRZ] = rz;

	        SetDynamicObjectPos(objectid, LadangData[etid][kanabisX], LadangData[etid][kanabisY], LadangData[etid][kanabisZ]);
	        SetDynamicObjectRot(objectid, LadangData[etid][kanabisRX], LadangData[etid][kanabisRY], LadangData[etid][kanabisRZ]);

		    Ladang_Save(etid);
	        AccountData[playerid][EditingLADANGID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = AccountData[playerid][EditingLADANGID];
	        SetDynamicObjectPos(objectid, LadangData[etid][kanabisX], LadangData[etid][kanabisY], LadangData[etid][kanabisZ]);
	        SetDynamicObjectRot(objectid, LadangData[etid][kanabisRX], LadangData[etid][kanabisRY], LadangData[etid][kanabisRZ]);
	        AccountData[playerid][EditingLADANGID] = -1;
	    }
	}
	else if(AccountData[playerid][EditingATMID] != -1 && Iter_Contains(ATMS, AccountData[playerid][EditingATMID]))
	{
		if(response == EDIT_RESPONSE_FINAL)
	    {
	        new etid = AccountData[playerid][EditingATMID];
	        AtmData[etid][atmX] = x;
	        AtmData[etid][atmY] = y;
	        AtmData[etid][atmZ] = z;
	        AtmData[etid][atmRX] = rx;
	        AtmData[etid][atmRY] = ry;
	        AtmData[etid][atmRZ] = rz;

	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);

		  	Atm_Refresh(etid);
		    Atm_Save(etid);
	        AccountData[playerid][EditingATMID] = -1;
	    }

	    if(response == EDIT_RESPONSE_CANCEL)
	    {
	        new etid = AccountData[playerid][EditingATMID];
	        SetDynamicObjectPos(objectid, AtmData[etid][atmX], AtmData[etid][atmY], AtmData[etid][atmZ]);
	        SetDynamicObjectRot(objectid, AtmData[etid][atmRX], AtmData[etid][atmRY], AtmData[etid][atmRZ]);
	        AccountData[playerid][EditingATMID] = -1;
	    }
	}
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(pMapCP[playerid])
	{
		InfoMsg(playerid, "Anda berhasil sampai ke lokasi tujuan");
		DisablePlayerRaceCheckpoint(playerid);
		pMapCP[playerid] = false;
	}
	if(AccountData[playerid][pTrackCar] == 1)
	{
		InfoMsg(playerid, "Anda berhasil sampai ke lokasi tujuan");
		AccountData[playerid][pTrackCar] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	if(AccountData[playerid][pTrackHoused] == 1)
	{
		InfoMsg(playerid, "Anda berhasil sampai ke lokasi tujuan");
		AccountData[playerid][pTrackHoused] = 0;
		DisablePlayerRaceCheckpoint(playerid);
	}
	/*if(AccountData[playerid][pDiPesawat])
	{
		DisablePlayerCheckpoint(playerid);
		AccountData[playerid][pDiPesawat] = false;
		AccountData[playerid][pPosX] = 1750.4976;
		AccountData[playerid][pPosY] = -2516.3225;
		AccountData[playerid][pPosZ] = 13.5969;
		AccountData[playerid][pPosA] = 90.1848;
		AccountData[playerid][pInDoor] = 7;
		SetPlayerVirtualWorldEx(playerid, 0);
		SetPlayerInteriorEx(playerid, 0);
		SetPlayerPositionEx(playerid, AccountData[playerid][pPosX], AccountData[playerid][pPosY], AccountData[playerid][pPosZ], AccountData[playerid][pPosA], 6000);
	}*/
	if(jobs::mixer[playerid][mixerDuty][1])
    {
        new vehid = GetPlayerVehicleID(playerid);
        
  
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || vehid != jobs::mixer[playerid][mixerVehicle])
        {
            return ErrorMsg(playerid, "Anda harus mengemudikan truk mixer Anda untuk menumpahkan beton!");
        }

        DisablePlayerCheckpoint(playerid);
        PlayerTextDrawSetString(playerid, PROGRESSBAR[playerid][21], "MENUMPAHKAN");
        ShowProgressBarNew(playerid);
		//for(new i = 0; i < 23; i++) PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][i]);
        jobs::mixer[playerid][mixerDuty][1] = false;
        AccountData[playerid][ActivityTime] = 1; // Hati-hati, pastikan nama enumnya benar (ActivityTime atau pActivityTime)
        jobs::mixer[playerid][mixerTimer] = SetTimerEx("CorLokasi", 1000, true, "i", playerid);
    }
    
    if(jobs::mixer[playerid][mixerDuty][2])
    {
        new vehid = GetPlayerVehicleID(playerid);
        
        // PENGAMAN: Jangan gunakan IsPlayerInAnyVehicle agar tidak bisa diakali pakai sepeda/mobil lain
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && vehid == jobs::mixer[playerid][mixerVehicle])
        {
            DisablePlayerCheckpoint(playerid);
            RemovePlayerFromVehicle(playerid);
            DestroyVehicle(vehid); // Hancurkan kendaraan yang benar
            GiveMoney(playerid, 2000); 
            jobs::mixer[playerid][mixerDuty][2] = false;
            jobs::mixer_reset_enum(playerid);
            AccountData[playerid][pDelayMixer] = gettime() + (30 * 60);
        }
        else
        {
            return ErrorMsg(playerid, "Anda harus membawa kembali truk mixer Anda untuk mengambil gaji!");
        }
    }
    return 1;
}
Dialog:DeathRespawnConf(playerid, response, listitem, inputtext[])
{
	if(!response) return 1;
	if(!IsPlayerInjured(playerid)) return ErrorMsg(playerid, "Anda tidak sedang Pingsan!");
			
	SetPlayerHealthEx(playerid, 100.0);
	AccountData[playerid][pHunger] = 100;
	AccountData[playerid][pThirst] = 100;
	AccountData[playerid][pStress] = 0;
	AccountData[playerid][pInjured] = 0;
	AccountData[playerid][pInjuredTime] = 0;
	Inventory_Clear(playerid);
	ResetPlayerWeaponsEx(playerid);
	
	InfoMsg(playerid, "Kamu koma dan dilarikan ke Rumah Sakit");

	SetPlayerPositionEx(playerid, 1362.16, 680.69, 11.81, 174.28, 5000);
	SetPlayerVirtualWorldEx(playerid, 0);
	SetPlayerInteriorEx(playerid, 0);

	foreach(new pid : Player) 
	{
		if(AccountData[pid][pFaction] == FACTION_EMS && AccountData[pid][pDutyEms]) 
		{
			SendClientMessageEx(pid, -1, ""YELLOW"[Koma]"WHITE_E" %s telah terbangun di ruang koma", ReturnName(playerid));
		}
	}

	AddPMoneyLog(AccountData[playerid][pName], AccountData[playerid][pUCP], "KOMA", 0);
	return 1;
}

forward StartVaping(playerid);
public StartVaping(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!AccountData[playerid][pIsSmokeBlowing]) return 0;

	if(AccountData[playerid][pUsingOutfit] == -1) 
		SetPlayerAttachedObject(playerid, 9, 18716, 2, 0.074000, -1.191000, 0.026997, -97.299995, 7.100001, 73.799980, 1.000000, 1.000000, 1.000000);
	SetTimerEx("EndVaping", 4255, false, "i", playerid);
	return 1;
}

forward EndVaping(playerid);
public EndVaping(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!AccountData[playerid][pIsSmokeBlowing]) return 0;

    AccountData[playerid][pStress] -= 5;
	if(AccountData[playerid][pStress] < 0) AccountData[playerid][pStress] = 0;

	if(AccountData[playerid][pSmokedTimes] >= 6)
	{
        if(GetPVarInt(playerid, "Vaping")) {
            if(AccountData[playerid][pUsingOutfit] == -1) 
				RemovePlayerAttachedObject(playerid, 8);
		}

		AccountData[playerid][pSmokedTimes] = 0;
	}
	AccountData[playerid][pIsSmokeBlowing] = false;

    if(GetPVarInt(playerid, "Vaping")) {
    	if(AccountData[playerid][pUsingOutfit] == -1) 
			RemovePlayerAttachedObject(playerid, 9);
	}

    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, false, false, false, false, 0, true);
	ClearAnimations(playerid, true);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys & KEY_YES) && GetPVarInt(playerid, "Vaping") && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {

		if(AccountData[playerid][pActivityTime] != 0) return Warning(playerid, "Anda sedang melakukan sesuatu, mohon tunggu progress bar selesai!");

		if(AccountData[playerid][pIsSmokeBlowing]) return 1;

		AccountData[playerid][pIsSmokeBlowing] = true;
		AccountData[playerid][pSmokedTimes]++;
		SetTimerEx("StartVaping", 2100, false, "i", playerid);
		ApplyAnimation(playerid, "SMOKING", "M_smk_drag", 4.1, false, false, false, false, 0, true);

	}
	/* Job Mixer */
	if(PRESSED(KEY_YES) && IsPlayerInRangeOfPoint(playerid, 2.0, 641.2187,1238.3390,11.6796))
    {
    	if(AccountData[playerid][pDelayMixer] > 0) return ErrorMsg(playerid, "Anda masi delay job mixer");
		if(jobs::mixer[playerid][mixerDuty][0]) return ErrorMsg(playerid, "Anda sudah memulai pekerjaan");
        if(GetPlayerJob(playerid) != JOB_DRIVER_MIXERS) return ErrorMsg(playerid, "Anda bukan pekerja supir mixer");
        jobs::mixer[playerid][mixerVehicle] = CreateVehicle(524, 639.8187,1250.2065,11.6333,306.5278, 5, 5, 60000, false);
		if(IsValidVehicle(jobs::mixer[playerid][mixerVehicle]))
		{
			VehicleCore[jobs::mixer[playerid][mixerVehicle]][vCoreFuel]=MAX_FUEL_FULL;
		    PutPlayerInVehicle(playerid, jobs::mixer[playerid][mixerVehicle], 0);
			jobs::mixer[playerid][mixerDuty][0] = true;
		}
        ShowPlayerFooter(playerid, "~w~~h~Isi kendaraan dengan ~g~beton ~w~di~n~belakang", 3000, 1);
    }
    if(PRESSED(KEY_CROUCH) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInRangeOfPoint(playerid, 3.0, 590.0992,1243.8767,11.7188))
    {
        if(GetPlayerJob(playerid) != JOB_DRIVER_MIXERS) return ErrorMsg(playerid, "Anda bukan pekerja supir mixer");
        ShowMixTD(playerid);
    }
	/* Senter */
	if(PRESSED(KEY_CTRL_BACK) && AccountData[playerid][pFlashShown] && !IsPlayerInAnyVehicle(playerid))
	{
		switch(AccountData[playerid][pFlashOn])
		{
			case false:
            {
				if (!IsPlayerPlayingAnimation(playerid, "ped", "phone_talk"))
				{
					ApplyAnimationEx(playerid, "ped", "phone_talk", 1.1, 1, 1, 1, 1, 1, 1);
				}
				
                AccountData[playerid][pFlashOn] = true;
				if(AccountData[playerid][pUsingOutfit] == -1)
                	SetPlayerAttachedObject(playerid, 5, 19295, 1,  0.068000, 0.606000, 0.000000,  0.000000, -4.500000, 12.299996,  1.000000, 1.000000, 1.020000); // Light Objects

                ShowPlayerFooter(playerid, "~w~Senter ~g~Nyala", 3000);
            }
            case true:
            {
                AccountData[playerid][pFlashOn] = false;
				if(AccountData[playerid][pUsingOutfit] == -1)
                	RemovePlayerAttachedObject(playerid, 5);

                ShowPlayerFooter(playerid, "~w~Senter ~r~Mati", 3000);
            }
		}
	}

	/* Greenzone */
	/*if(newkeys & KEY_FIRE && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && IsPlayerInDynamicArea(playerid, AreaData[BandaraGreenZone]))
	{
		ClearAnimations(playerid, 1);
        SetPlayerArmedWeapon(playerid, 0);

        SetPVarInt(playerid, "GreenzoneWarning", GetPVarInt(playerid, "GreenzoneWarning")+1);
		//Info(playerid, "Anda tidak dapat memukul / menembak di Area Greenzone. "RED"%d/5"WHITE" anda akan ditendang dari server.", GetPVarInt(playerid, "GreenzoneWarning"));
		new strings[258];
		format(strings, 188, "{FFFFFF}Anda Berada Di Area {33AA33}Green Zone{FFFFFF}, dimana kamu tidak bisa bertarung\n\
		Ketika anda mencoba lagi, Anda akan terputus dari server. ({ff0000}Warning %d/5{ffffff})", GetPVarInt(playerid, "GreenzoneWarning"));
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Green Zone", strings, "Tutup", "");

        if(GetPVarInt(playerid, "GreenzoneWarning") == 5) 
		{
			Warning(playerid, "Anda telah ditendang dari server karena mendapatkan "RED"5"WHITE" peringatan Greenzone!");
			DeletePVar(playerid, "GreenzoneWarning");
            KickEx(playerid);
        }
	}*/

	if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !IsPlayerInEvent(playerid) && !DurringHunting[playerid] && !AccountData[playerid][pAdminDuty])
	{
		PlayerPressedJump[playerid] ++;
		SetTimerEx("PressJumpReset", 3000, false, "d", playerid); // Makes it where if they dont spam the jump key, they wont fall

		if(PlayerPressedJump[playerid] >= 5)
		{ 
			new Float: POS[3];
			GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
			SetPlayerPos(playerid, POS[0], POS[1], POS[2] - 0.2);
			ApplyAnimationEx(playerid, "PED", "FALL_collapse", 4.1, 0, 1, 0, 0, 0, 1); // applies the fallover animation
			PlayerPlayNearbySound(playerid, 1163);
			PlayerPressedJump[playerid] = 0;
		}
	}

	/* Voting Systemm */
	if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && !AccountData[playerid][pInjured])
	{
		if(AccountData[playerid][pRFoot] < 50 || AccountData[playerid][pLFoot] < 50)
		{
			ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
		}
	}

	if(newkeys & KEY_YES && OpenVote == 1 && !PlayerVoting[playerid] && !AccountData[playerid][ActivityTime])
	{

		SuccesMsg(playerid, "Anda Setuju untuk Voting yang sedang berjalan");

		PlayerVoting[playerid] = true;
		VoteYes += 1;
		SendClientMessageToAllEx(-1, ""YELLOW"VOTE:"WHITE" %s // Yes: "GREEN"%d"WHITE" // No: "RED"%d", VoteText, VoteYes, VoteNo);
		SendClientMessageToAllEx(-1, "~> Gunakan "GREEN"Y"WHITE" untuk Yes & "RED"N"WHITE" untuk Tidak");
	}

	if(newkeys & KEY_NO && OpenVote == 1 && !PlayerVoting[playerid] && !AccountData[playerid][ActivityTime])
	{

		SuccesMsg(playerid, "Anda Tidak Setuju untuk Voting yang sedang berjalan");

		PlayerVoting[playerid] = true;
		VoteNo += 1;
		SendClientMessageToAllEx(-1, ""YELLOW"VOTE:"WHITE" %s // Yes: "GREEN"%d"WHITE" // No: "RED"%d", VoteText, VoteYes, VoteNo);
		SendClientMessageToAllEx(-1, "~> Gunakan "GREEN"Y"WHITE" untuk Yes & "RED"N"WHITE" untuk Tidak");
	}

	/* Anti Bike Hopping */
	if(PRESSED(KEY_ACTION))
	{
		static vehicleid;

		if(IsPlayerInAnyVehicle(playerid) && ((vehicleid = GetPlayerVehicleID(playerid)) != INVALID_VEHICLE_ID))
		{
			if(GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 510)
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				SetPlayerPos(playerid, x, y, z);

				ApplyAnimationEx(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
			}
		}
	}

	if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED && !AccountData[playerid][pInjured])
	{
		ApplyAnimation(playerid, "GYMNASIUM", "gym_jog_falloff", 4.1, 0, 1, 1, 0, 0);
	}
	/*if(newkeys & KEY_NO)
	{
		if(AccountData[playerid][pInjured])
		{
		    Dialog_Show(playerid, DeathRespawnConf, DIALOG_STYLE_MSGBOX, ""JAVA"KARSA "WHITE"- Konfirmasi Koma",
		    "Apakah anda benar benar yakin ingin melakukan tindakan ini?\n"RED"NOTE: Tindakan ini dapat menghilangkan semua barang di tas termasuk uang cash", "Iya", "Tidak");
		}
	}*/
	if(newkeys & KEY_SECONDARY_ATTACK && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
		foreach(new famid : Families)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, FamData[famid][famExtPos][0], FamData[famid][famExtPos][1], FamData[famid][famExtPos][2]))
			{
				if(IsDoorMyFamilie(playerid) == AccountData[playerid][pFamily])
				{
					if(FamData[famid][famIntPos][0] == 0.0 && FamData[famid][famIntPos][1] == 0.0 && FamData[famid][famIntPos][2] == 0.0)
						return ErrorMsg(playerid, "Interior ini masih kosong!");

					if(AccountData[playerid][pFaction] == FACTION_NONE)
						if(AccountData[playerid][pFamily] == -1)
							return ErrorMsg(playerid, "Kamu tidak memiliki Akses untuk masuk kedalam sini!");
					
					OnFakespawnCheck(playerid);

					AccountData[playerid][UsingDoor] = true;
					Player_ToggleTelportAntiCheat(playerid, false);
					SetPlayerPositionEx(playerid, FamData[famid][famIntPos][0], FamData[famid][famIntPos][1], FamData[famid][famIntPos][2], FamData[famid][famIntPos][3], 5000);

					SetPlayerInterior(playerid, FamData[famid][famInterior]);
					SetPlayerVirtualWorld(playerid, famid);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, 0);
					AccountData[playerid][pInFamily] = famid;
					break;
				}
				else ErrorMsg(playerid, "Anda bukan bagian dari Families ini!");
			}
			new infamily = AccountData[playerid][pInFamily];
			if(AccountData[playerid][pInFamily] != -1 && IsPlayerInRangeOfPoint(playerid, 2.5, FamData[infamily][famIntPos][0], FamData[infamily][famIntPos][1],FamData[infamily][famIntPos][2]))
			{
				OnFakespawnCheck(playerid);
				AccountData[playerid][pInFamily] = -1;
				AccountData[playerid][UsingDoor] = true;
				Player_ToggleTelportAntiCheat(playerid, false);
				SetPlayerPositionEx(playerid, FamData[infamily][famExtPos][0], FamData[infamily][famExtPos][1], FamData[infamily][famExtPos][2], FamData[infamily][famExtPos][3], 5000);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
				Player_ToggleTelportAntiCheat(playerid, true);
			}
		}
	}
	
	if(newkeys & KEY_LOOK_BEHIND)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return 0;

		new vehid = GetNearestVehicleToPlayer(playerid, 3.0, false);
		if(vehid == INVALID_VEHICLE_ID) return ErrorMsg(playerid, "Tidak ada kendaraan apapun di sekitar!");

		foreach(new iter : PvtVehicles)
		{
			if(PlayerVehicle[iter][pVehExists])
			{
				if(PlayerVehicle[iter][pVehPhysic] == vehid)
				{
					if(PlayerVehicle[iter][pVehOwnerID] == AccountData[playerid][pID] || PlayerVehicle[iter][pVehKey][0] == AccountData[playerid][pID] || PlayerVehicle[iter][pVehKey][1] == AccountData[playerid][pID] || PlayerVehicle[iter][pVehKey][2] == AccountData[playerid][pID]) 
					{
						PlayerPlaySound(playerid, 1147, 0.0, 0.0, 0.0);
						PlayerVehicle[iter][pVehLocked] = !(PlayerVehicle[iter][pVehLocked]);

						PlayerPlayNearbySound(playerid, SOUND_LOCK_CAR_DOOR);
						LockVehicle(PlayerVehicle[iter][pVehPhysic], PlayerVehicle[iter][pVehLocked]);
						ToggleVehicleLights(PlayerVehicle[iter][pVehPhysic], PlayerVehicle[iter][pVehLocked]);
						GameTextForPlayer(playerid, sprintf("~w~%s %s", GetVehicleName(PlayerVehicle[iter][pVehPhysic]), PlayerVehicle[iter][pVehLocked] ? ("~r~Locked") : ("~g~Unlocked")), 4000, 4);
					}
					else ErrorMsg(playerid, "Anda tidak memiliki akses ke kendaraan ini!");
					return 1;
				}
			}
		}

		if(AccountData[playerid][pJobVehicle] != 0)
		{
			if (vehid == JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle])
			{
				PlayerPlaySound(playerid, 1147, 0.0, 0.0, 0.0);
				JobVehicle[AccountData[playerid][pJobVehicle]][Locked] = !(JobVehicle[AccountData[playerid][pJobVehicle]][Locked]);

				PlayerPlayNearbySound(playerid, SOUND_LOCK_CAR_DOOR);
				LockVehicle(JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle], JobVehicle[AccountData[playerid][pJobVehicle]][Locked]);
				ToggleVehicleLights(JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle], JobVehicle[AccountData[playerid][pJobVehicle]][Locked]);
				GameTextForPlayer(playerid, sprintf("~w~%s %s", GetVehicleName(JobVehicle[AccountData[playerid][pJobVehicle]][Vehicle]), JobVehicle[AccountData[playerid][pJobVehicle]][Locked] ? ("~r~Locked") : ("~g~Unlocked")), 4000, 4);
			}
			return 1;
		}

		if(PlayerElectricJob[playerid][ElectricVehicle] == vehid)
		{
			PlayerPlaySound(playerid, 1147, 0.0, 0.0, 0.0);
			PlayerElectricJob[playerid][ElectricLocked] = !(PlayerElectricJob[playerid][ElectricLocked]);

			PlayerPlayNearbySound(playerid, SOUND_LOCK_CAR_DOOR);
			LockVehicle(PlayerElectricJob[playerid][ElectricVehicle], PlayerElectricJob[playerid][ElectricLocked]);
			ToggleVehicleLights(PlayerElectricJob[playerid][ElectricVehicle], PlayerElectricJob[playerid][ElectricLocked]);
			GameTextForPlayer(playerid, sprintf("~w~%s %s", GetVehicleName(PlayerElectricJob[playerid][ElectricVehicle]), PlayerElectricJob[playerid][ElectricLocked] ? ("~r~Locked") : ("~g~Unlocked")), 4000, 4);
			return 1;
		}
	}
	if(newkeys & KEY_CTRL_BACK)
	{
		if(IsPlayerInjured(playerid))
		{
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(AccountData[playerid][pInjured])
		{
			if(SignalExists[playerid]) return WarningMsg(playerid, "Anda sudah mengirim signal, tunggu hingga EMS merespon!");
			
			GetPlayerPos(playerid, SignalPos[playerid][0], SignalPos[playerid][1], SignalPos[playerid][2]);
			SignalExists[playerid] = true;
			SignalTimer[playerid] = 120;
			SuccesMsg(playerid, "Berhasil mengirim sinyal kepada EMS!");
			foreach(new i : Player) if (AccountData[i][pSpawned] && AccountData[i][pFaction] == FACTION_EMS) if (AccountData[i][pDutyEms])
			{
				SendClientMessageEx(i, -1, ""RED"[Emergency Signal]"WHITE" Signal terlah diterima dari daerah "YELLOW"%s", GetLocation(SignalPos[playerid][0], SignalPos[playerid][1], SignalPos[playerid][2]));
				Info(i, "Buka Smartphone ~> GPS ~> Signal Emergency (EMS) jika ingin merespon signal");
			}
		}
	}
	if((newkeys & KEY_NO) && aOfferID[playerid] == INVALID_PLAYER_ID)
	{
		if (AccountData[playerid][ActivityTime] != 0) return WarningMsg(playerid, "Tidak dapat membuka radial saat actvitity berjalan!");
		if (AccountData[playerid][pInjured]) return WarningMsg(playerid, "Anda tidak dapat melakukan ini ketika sedang pingsan!");
		
		// ShowPlayerRadial(playerid, true);
		ShowRD1(playerid, true);
	}
	//-----[ Toll System ]-----	
	if(newkeys & KEY_CROUCH)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new forcount = MuchNumber(sizeof(BarrierInfo));
			for(new i = 0; i < forcount;i ++)
			{
				if(i < sizeof(BarrierInfo))
				{
					if(IsPlayerInRangeOfPoint(playerid,8.0,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]))
					{
						if(BarrierInfo[i][brOrg] == TEAM_NONE)
						{
							if(!BarrierInfo[i][brOpen])
							{
								if(AccountData[playerid][pMoney] < 100 && !IsVehicleFaction(GetPlayerVehicleID(playerid)))
								{
									InfoMsg(playerid, "Anda membutuhkan "YELLOW"$100"WHITE" untuk membayar Toll");
								}
								else if(IsVehicleFaction(GetPlayerVehicleID(playerid)))
								{
									MoveDynamicObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
									SetTimerEx("BarrierClose", 5000,0,"i",i);
									BarrierInfo[i][brOpen] = true;
									InfoMsg(playerid, "Hati hati dijalan, Pintu akan tertutup selama 5 detik");
									if(BarrierInfo[i][brForBarrierID] != -1)
									{
										new barrierid = BarrierInfo[i][brForBarrierID];
										MoveDynamicObject(gBarrier[barrierid],BarrierInfo[barrierid][brPos_X],BarrierInfo[barrierid][brPos_Y],BarrierInfo[barrierid][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[barrierid][brPos_A]+180);
										BarrierInfo[barrierid][brOpen] = true;
									}
								}
								else
								{
									MoveDynamicObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
									SetTimerEx("BarrierClose", 5000,0,"i",i);
									BarrierInfo[i][brOpen] = true;
									InfoMsg(playerid, "Hati hati dijalan, Pintu akan tertutup selama 5 detik");
									ShowItemBox(playerid, "Removed $100", "Uang", 1212);
									TakeMoney(playerid, 100);
									if(BarrierInfo[i][brForBarrierID] != -1)
									{
										new barrierid = BarrierInfo[i][brForBarrierID];
										MoveDynamicObject(gBarrier[barrierid],BarrierInfo[barrierid][brPos_X],BarrierInfo[barrierid][brPos_Y],BarrierInfo[barrierid][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[barrierid][brPos_A]+180);
										BarrierInfo[barrierid][brOpen] = true;
									}
								}
							}
						}
						else ErrorMsg(playerid, "Anda tidak dapat membuka toll ini!");
						break;
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if((oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) && AccountData[playerid][pTogAutoEngine])
	{
		if(!GetEngineStatus(vehicleid))
		{
			if(IsEngineVehicle(vehicleid) && !IsADealerVehicle(playerid, vehicleid))
			{
				callcmd::en(playerid, "");
				// AccountData[playerid][pTurningEngine] = true;
				// SetTimerEx("EngineStatus", 2500, false, "id", playerid, vehicleid);
				// SendRPMeAboveHead(playerid, "Mencoba menghidupkan mesin kendaraan", X11_PLUM1); 
			}

			for(new x = 0; x < 5; x++) PlayerTextDrawHide(playerid, HbePNew[playerid][x]);
			for(new x = 0; x < 22; x++) TextDrawHideForPlayer(playerid, HbeGNew[x]);
		}
	}
	if(newstate == PLAYER_STATE_WASTED && AccountData[playerid][pJail] < 1)
    {	
		if(IsPlayerInEvent(playerid))
			return 1;

		SetPlayerArmedWeapon(playerid, 0);
		ResetPlayer(playerid);

		if(!AccountData[playerid][pInjured] && !IsPlayerInEvent(playerid))
		{
			AccountData[playerid][pInjured] = 1;
			AccountData[playerid][pInjuredTime] = 1800;
			
			AccountData[playerid][pInt] = GetPlayerInterior(playerid);
			AccountData[playerid][pWorld] = GetPlayerVirtualWorld(playerid);

			GetPlayerPos(playerid, AccountData[playerid][pPosX], AccountData[playerid][pPosY], AccountData[playerid][pPosZ]);
			GetPlayerFacingAngle(playerid, AccountData[playerid][pPosA]);
			SetSpawnInfo(playerid, NO_TEAM, GetPlayerSkin(playerid), AccountData[playerid][pPosX], AccountData[playerid][pPosY], AccountData[playerid][pPosZ], AccountData[playerid][pPosA], 0, 0, 0, 0, 0, 0);
		}
	}
	//Spec Player
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		if(AccountData[playerid][playerSpectated] != 0)
		{
			foreach(new ii : Player)
			{
				if(AccountData[ii][pSpec] == playerid)
				{
					PlayerSpectatePlayer(ii, playerid);
					SendClientMessageEx(ii, -1, ""YELLOW"SPEC:"WHITE" %s(%d) sekarang berjalan kaki.", AccountData[playerid][pName], playerid);
				}
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
		OnFakespawnCheck(playerid);
		if(AccountData[playerid][pInjured] == 1)
        {
            //RemoveFromVehicle(playerid);
			RemovePlayerFromVehicle(playerid);
            SetPlayerHealthEx(playerid, 99999);
			Info(playerid, "Anda sedang pingsan!");
        }
		foreach (new ii : Player) if(AccountData[ii][pSpec] == playerid) 
		{
            PlayerSpectateVehicle(ii, GetPlayerVehicleID(playerid));
        }
		//GangZoneHideForPlayer(playerid, GangZoneData[gzSafezone]);
	}
    
	new vehicle_index = -1;
	if((vehicle_index = Vehicle_ReturnID(vehicleid)) != RETURN_INVALID_VEHICLE_ID)
	{
		if((newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER) && PlayerVehicle[vehicle_index][vehAudio])
		{
			PlayVehicleAudio(playerid, vehicle_index);
		}
	}
	
	if((oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER) && AccountData[playerid][pVehAudioPlay])
	{
		StopAudioStreamForPlayer(playerid);
		AccountData[playerid][pVehAudioPlay] = 0;
	}
	if(oldstate == PLAYER_STATE_DRIVER)
    {	
		HideSpeed(playerid);
	}
	/*if(oldstate == PLAYER_STATE_PASSENGER)
	{
		GangZoneShowForPlayer(playerid, GangZoneData[gzSafezone], 0xFFB6C1EE);
	}
	else*/ 
	if(newstate == PLAYER_STATE_DRIVER)
    {	
		static pviterid = -1;

		if((pviterid = Vehicle_Nearest2(playerid)) != -1)
		{
			if(IsABike(PlayerVehicle[pviterid][pVehPhysic]) || GetVehicleModel(PlayerVehicle[pviterid][pVehPhysic]) == 424)
			{
				if(PlayerVehicle[pviterid][pVehLocked])
				{
					RemovePlayerFromVehicle(playerid);
					ClearAnimations(playerid, 1);
					ErrorMsg(playerid, "Kendaraan ini terkunci!");
					return 1;
				}
			}
		}
		if(!IsEngineVehicle(vehicleid))
        {
            SwitchVehicleEngine(vehicleid, true);
        }
		else{
			if(GetPVarInt(playerid, "SelectShowroomID") == 0)
			for(new i = 0; i < 38; i++)
			{
				TextDrawShowForPlayer(playerid, ui_vehiclemenu[i]);
			}
			SelectTextDraw(playerid, COLOR_GREY);
		}
		/*for(new i; i<14; i++)
		{
			TextDrawShowForPlayer(playerid, Speedo_Index[i]);
		}
		PlayerTextDrawShow(playerid, Speedo_KMH[playerid]);
		PlayerTextDrawShow(playerid, Speedo_Location[playerid]);
		PlayerTextDrawShow(playerid, Speedo_Fuel[playerid]);*/
		ShowSpeed(playerid);
		new Float:health;
        GetVehicleHealth(GetPlayerVehicleID(playerid), health);
        VehicleHealthSecurityData[GetPlayerVehicleID(playerid)] = health;
        VehicleHealthSecurity[GetPlayerVehicleID(playerid)] = true;
		
		if(AccountData[playerid][playerSpectated] != 0)
  		{
			foreach(new ii : Player)
			{
    			if(AccountData[ii][pSpec] == playerid)
			    {
        			PlayerSpectateVehicle(ii, vehicleid);
					SendClientMessageEx(ii, -1, ""YELLOW"SPEC:"WHITE" %s(%d) sekarang mengendarai %s(%d).", AccountData[playerid][pName], playerid, GetVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
				}
			}
		}
		SetPVarInt(playerid, "LastVehicleID", vehicleid);
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	OnFakespawnCheck(playerid);

	switch(weaponid){ case 0..18, 39..54: return 1;} //invalid weapons
	if(1 <= weaponid <= 46 && AccountData[playerid][pGuns][g_aWeaponSlots[weaponid]] == weaponid)
	{
		AccountData[playerid][pAmmo][g_aWeaponSlots[weaponid]]--;
		if(AccountData[playerid][pGuns][g_aWeaponSlots[weaponid]] != 0 && !AccountData[playerid][pAmmo][g_aWeaponSlots[weaponid]])
		{
			AccountData[playerid][pGuns][g_aWeaponSlots[weaponid]] = 0;
		}
	}

	if(PlayerHasTazer(playerid) && AccountData[playerid][pFaction] == FACTION_POLISI)
	{
		SetPlayerArmedWeapon(playerid, 0);
		PlayerPlayNearbySound(playerid, 6003);
	}
	return 1;
}

stock GivePlayerHealth(playerid,Float:Health)
{
	new Float:health; GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+Health);
}

/*public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    new Float:health = GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);
    if(AccountData[playerid][pSeatBelt] == 0 || AccountData[playerid][pHelmetOn] == 0)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		AccountData[playerid][pLFoot] -= csakit;
    		AccountData[playerid][pLHand] -= bsakit;
    		AccountData[playerid][pRFoot] -= csakit;
    		AccountData[playerid][pRHand] -= bsakit;
    		AccountData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 2);
    		new bsakit = RandomEx(0, 2);
    		new csakit = RandomEx(0, 2);
    		new dsakit = RandomEx(0, 2);
    		AccountData[playerid][pLFoot] -= dsakit;
    		AccountData[playerid][pLHand] -= bsakit;
    		AccountData[playerid][pRFoot] -= csakit;
    		AccountData[playerid][pRHand] -= dsakit;
    		AccountData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -2);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 3);
    		new bsakit = RandomEx(0, 3);
    		new csakit = RandomEx(0, 3);
    		new dsakit = RandomEx(0, 3);
    		AccountData[playerid][pLFoot] -= csakit;
    		AccountData[playerid][pLHand] -= csakit;
    		AccountData[playerid][pRFoot] -= dsakit;
    		AccountData[playerid][pRHand] -= bsakit;
    		AccountData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -5);
    		return 1;
    	}
    	return 1;
    }
    if(AccountData[playerid][pSeatBelt] == 1 || AccountData[playerid][pHelmetOn] == 1)
    {
    	if(GetVehicleSpeed(vehicleid) <= 20)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		AccountData[playerid][pLFoot] -= csakit;
    		AccountData[playerid][pLHand] -= bsakit;
    		AccountData[playerid][pRFoot] -= csakit;
    		AccountData[playerid][pRHand] -= bsakit;
    		AccountData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 50)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		AccountData[playerid][pLFoot] -= dsakit;
    		AccountData[playerid][pLHand] -= bsakit;
    		AccountData[playerid][pRFoot] -= csakit;
    		AccountData[playerid][pRHand] -= dsakit;
    		AccountData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -1);
    		return 1;
    	}
    	if(GetVehicleSpeed(vehicleid) <= 90)
    	{
    		new asakit = RandomEx(0, 1);
    		new bsakit = RandomEx(0, 1);
    		new csakit = RandomEx(0, 1);
    		new dsakit = RandomEx(0, 1);
    		AccountData[playerid][pLFoot] -= csakit;
    		AccountData[playerid][pLHand] -= csakit;
    		AccountData[playerid][pRFoot] -= dsakit;
    		AccountData[playerid][pRHand] -= bsakit;
    		AccountData[playerid][pHead] -= asakit;
    		GivePlayerHealth(playerid, -3);
    		return 1;
    	}
    }
    return 1;
}*/

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{

	OnFakespawnCheck(playerid);
	
	if(damagedid != INVALID_PLAYER_ID && weaponid == WEAPON_CHAINSAW) {
        TogglePlayerControllable(playerid, 0);
        SetPlayerArmedWeapon(playerid, 0);
        TogglePlayerControllable(playerid, 1);
        SetCameraBehindPlayer(playerid);

        SetPVarInt(playerid, "ChainsawWarning", GetPVarInt(playerid, "ChainsawWarning")+1);

        if(GetPVarInt(playerid, "ChainsawWarning") == 3) {
			SendClientMessageToAllEx(X11_RED, "[AntiCheat]:"YELLOW" %s(%d)"LIGHTGREY" telah ditendang dari server karena Abusing Chainsaw!", ReturnName(playerid), playerid);
            DeletePVar(playerid, "ChainsawWarning");
            KickEx(playerid);
        }
    }
	else if(damagedid != INVALID_PLAYER_ID)
	{
		AccountData[damagedid][pLastShot] = playerid;
		AccountData[damagedid][pShotTime] = gettime();
		new Float:darah;
		GetPlayerHealth(damagedid, darah);
		if(AccountData[playerid][pFaction] == FACTION_POLISI && PlayerHasTazer(playerid) && !AccountData[damagedid][pStunned])
		{
			if(GetPlayerState(damagedid) != PLAYER_STATE_ONFOOT)
				return ErrorMsg(playerid, "Pemain tersebut harus keadaan onfoot untuk dilumpuhkan!");
			
			if(GetPlayerDistanceFromPlayer(playerid, damagedid) > 5.0)
				return ErrorMsg(playerid, "Kamu harus lebih dekat untuk melumpuhkan pemain tersebut!");
			
			AccountData[damagedid][pStunned] = 10;
			SetPlayerHealthEx(damagedid, darah);
			TogglePlayerControllable(damagedid, 0);
			
			ApplyAnimation(damagedid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
			WarningMsg(damagedid, "Kamu terkena stun gun / taser!");
		}
	}
	else if(damagedid != INVALID_PLAYER_ID) 
	{
        if(AccountData[playerid][pNewBie] == 1)
        {
        	StopLoopingAnim(playerid);
	        ClearAnimations(playerid, 1);
	        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        	SendClientMessageEx(playerid, -1, ""ORANGE"[WARNING] "WHITE"Anda tidak bisa memukul saat ini, karena masi dalam masa warga baru!");
        }
    }
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if(!IsPlayerInEvent(playerid))
	{
		new sakit = RandomEx(1, 4);
		new asakit = RandomEx(1, 5);
		new bsakit = RandomEx(1, 7);
		new csakit = RandomEx(1, 4);
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 9)
		{
			AccountData[playerid][pHead] -= 20;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 3)
		{
			AccountData[playerid][pPerut] -= sakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 6)
		{
			AccountData[playerid][pRHand] -= bsakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 5)
		{
			AccountData[playerid][pLHand] -= asakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 8)
		{
			AccountData[playerid][pRFoot] -= csakit;
		}
		if(issuerid != INVALID_PLAYER_ID && GetPlayerWeapon(issuerid) && bodypart == 7)
		{
			AccountData[playerid][pLFoot] -= bsakit;	
		}
	}
	if(issuerid != INVALID_PLAYER_ID && bodypart == 3 && weaponid >= 22 && weaponid <= 45)
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		foreach(new i : Player) if (IsPlayerConnected(i)) if (SQL_IsCharacterLogged(i))
		{
			if(AccountData[i][pFaction] == FACTION_POLISI && AccountData[i][pDutyPD])
			{
				SendClientMessageEx(i, X11_ORANGE1, "[WAR ALERT]"WHITE" Terdeteksi penembakan di daerah %s.", GetLocation(x, y, z));
			}
		}
	}
    return 1;
}

ptask Inspike_Timer[1000](playerid)
{
	if(!AccountData[playerid][pSpawned]) 
		return 0;

	static s_Keys, s_UpDown, s_LeftRight;
    GetPlayerKeys( playerid, s_Keys, s_UpDown, s_LeftRight );

    if ( AccountData[playerid][pFreeze] && ( s_Keys || s_UpDown || s_LeftRight ) )
        return 0;

	CheckPlayerInSpike(playerid);
    return 1;
}

task VehicleUpdate[30000]()
{
	foreach(new i: Vehicle) if (IsEngineVehicle(i) && GetEngineStatus(i))
	{
		if (GetFuel(i) > 0)
		{
			VehicleCore[i][vCoreFuel] --;
			if (GetFuel(i) <= 0)
			{
				SwitchVehicleEngine(i, false);
				VehicleCore[i][vCoreFuel] = 0;
			}
		}
	}
	return 1;
}

timer Vehicle_UpdatePosition[2000](vehicleid)
{
	new
		Float:x,
		Float:y,
		Float:z,
		Float:a
	;

	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, a);

	SetVehiclePos(vehicleid, x, y, z);
	SetVehicleZAngle(vehicleid, a);
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new
        Float: vehicleHealth,
        playerVehicleId = GetPlayerVehicleID(playerid);

    new Float:health = GetPlayerHealth(playerid, health);
    GetVehicleHealth(playerVehicleId, vehicleHealth);


	if(!gToggleELM[vehicleid]) {
		if(AccountData[playerid][pSeatBelt] == 0 || AccountData[playerid][pHelmetOn] == 0)
		{
			if(GetVehicleSpeed(vehicleid) <= 20)
			{
				new asakit = RandomEx(0, 1);
				new bsakit = RandomEx(0, 1);
				new csakit = RandomEx(0, 1);
				AccountData[playerid][pLFoot] -= csakit;
				AccountData[playerid][pLHand] -= bsakit;
				AccountData[playerid][pRFoot] -= csakit;
				AccountData[playerid][pRHand] -= bsakit;
				AccountData[playerid][pHead] -= asakit;
				GivePlayerHealth(playerid, -1);
				return 1;
			}
			if(GetVehicleSpeed(vehicleid) <= 50)
			{
				new asakit = RandomEx(0, 2);
				new bsakit = RandomEx(0, 2);
				new csakit = RandomEx(0, 2);
				new dsakit = RandomEx(0, 2);
				AccountData[playerid][pLFoot] -= dsakit;
				AccountData[playerid][pLHand] -= bsakit;
				AccountData[playerid][pRFoot] -= csakit;
				AccountData[playerid][pRHand] -= dsakit;
				AccountData[playerid][pHead] -= asakit;
				GivePlayerHealth(playerid, -2);
				return 1;
			}
			if(GetVehicleSpeed(vehicleid) <= 90)
			{
				new asakit = RandomEx(0, 3);
				new bsakit = RandomEx(0, 3);
				new csakit = RandomEx(0, 3);
				new dsakit = RandomEx(0, 3);
				AccountData[playerid][pLFoot] -= csakit;
				AccountData[playerid][pLHand] -= csakit;
				AccountData[playerid][pRFoot] -= dsakit;
				AccountData[playerid][pRHand] -= bsakit;
				AccountData[playerid][pHead] -= asakit;
				GivePlayerHealth(playerid, -5);
				return 1;
			}
			return 1;
		}
		if(AccountData[playerid][pSeatBelt] == 1 || AccountData[playerid][pHelmetOn] == 1)
		{
			if(GetVehicleSpeed(vehicleid) <= 20)
			{
				new asakit = RandomEx(0, 1);
				new bsakit = RandomEx(0, 1);
				new csakit = RandomEx(0, 1);
				AccountData[playerid][pLFoot] -= csakit;
				AccountData[playerid][pLHand] -= bsakit;
				AccountData[playerid][pRFoot] -= csakit;
				AccountData[playerid][pRHand] -= bsakit;
				AccountData[playerid][pHead] -= asakit;
				GivePlayerHealth(playerid, -1);
				return 1;
			}
			if(GetVehicleSpeed(vehicleid) <= 50)
			{
				new asakit = RandomEx(0, 1);
				new bsakit = RandomEx(0, 1);
				new csakit = RandomEx(0, 1);
				new dsakit = RandomEx(0, 1);
				AccountData[playerid][pLFoot] -= dsakit;
				AccountData[playerid][pLHand] -= bsakit;
				AccountData[playerid][pRFoot] -= csakit;
				AccountData[playerid][pRHand] -= dsakit;
				AccountData[playerid][pHead] -= asakit;
				GivePlayerHealth(playerid, -1);
				return 1;
			}
			if(GetVehicleSpeed(vehicleid) <= 90)
			{
				new asakit = RandomEx(0, 1);
				new bsakit = RandomEx(0, 1);
				new csakit = RandomEx(0, 1);
				new dsakit = RandomEx(0, 1);
				AccountData[playerid][pLFoot] -= csakit;
				AccountData[playerid][pLHand] -= csakit;
				AccountData[playerid][pRFoot] -= dsakit;
				AccountData[playerid][pRHand] -= bsakit;
				AccountData[playerid][pHead] -= asakit;
				GivePlayerHealth(playerid, -3);
				return 1;
			}
		}
	}


	new vehicle_index; // Index = Vehicle id ingame, vehicleid = Index DB
    vehicle_index = Vehicle_ReturnID(vehicleid);
    if(vehicle_index != RETURN_INVALID_VEHICLE_ID)
    {
		new panels, doors, lights, tires;
		GetVehicleDamageStatus(PlayerVehicle[vehicle_index][pVehPhysic], panels, doors, lights, tires);
		if(PlayerVehicle[vehicle_index][pVehBodyUpgrade] == 3 && PlayerVehicle[vehicle_index][pVehBodyRepair] > 0)
		{
			panels = doors = lights = tires = 0;
            UpdateVehicleDamageStatus(PlayerVehicle[vehicle_index][pVehPhysic], panels, doors, lights, tires);
			PlayerVehicle[vehicle_index][pVehBodyRepair] -= 50.0;
		}
		else if(PlayerVehicle[vehicle_index][pVehBodyRepair] <= 0)
		{
			PlayerVehicle[vehicle_index][pVehBodyRepair] = 0;
		}
	}
	if(GetPlayerJob(playerid) == JOB_DRIVER_MIXERS){
		if(jobs::mixer[playerid][mixerSlump] > 0 && IsValidVehicle(vehicleid))
		{
			new rand = RandomEx(2,4);
			jobs::mixer[playerid][mixerSlump]-=rand;

			new Float: progressvalue; 
			progressvalue = jobs::mixer[playerid][mixerSlump]*61/100;
			PlayerTextDrawTextSize(playerid, jobs::PBMixer[playerid], progressvalue, 13.0);
			PlayerTextDrawShow(playerid, jobs::PBMixer[playerid]);
		}
	}
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	new Float: vhealth;

	AntiCheatGetVehicleHealth(vehicleid, vhealth);
	SetVehicleHealth(vehicleid, vhealth);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	defer Vehicle_UpdatePosition(vehicleid);

	for (new vid = 1; vid < sizeof(JobVehicle); vid ++) if (JobVehicle[vid][Vehicle] != INVALID_VEHICLE_ID)
	{
		if (vehicleid == JobVehicle[vid][Vehicle])
		{
			foreach(new i : Player)
			{
				if (AccountData[i][pJobVehicle] == JobVehicle[vid][Vehicle])
				{
					if (AccountData[i][pJobVehicle] != 0)
					{
						DestroyJobVehicle(i);
						AccountData[i][pJobVehicle] = 0;
						break;
					}
				}
			}
		}
	}

	foreach(new i : PvtVehicles) if (vehicleid == PlayerVehicle[i][pVehPhysic] && IsValidVehicle(PlayerVehicle[i][pVehPhysic]))
	{
		if (PlayerVehicle[i][pVehRental] == -1)
		{
			PlayerVehicle[i][pVehInsuranced] = true;
			
			foreach(new pid : Player) if(PlayerVehicle[i][pVehOwnerID] == AccountData[pid][pID])
			{
				Syntax(pid, "Kendaraan anda rusak dan sudah dikirimkan ke Asuransi!");
			}
			
			for (new slot = 0; slot < MAX_VEHICLE_OBJECT; slot ++) if (VehicleObjects[i][slot][vehObjectExists])
			{
				if (VehicleObjects[i][slot][vehObject] != INVALID_STREAMER_ID)
					DestroyDynamicObject(VehicleObjects[i][slot][vehObject]);
				
				VehicleObjects[i][slot][vehObject] = INVALID_STREAMER_ID;
			}

			if (IsValidVehicle(PlayerVehicle[i][pVehPhysic]))
				DestroyVehicle(PlayerVehicle[i][pVehPhysic]);
			
			PlayerVehicle[i][pVehPhysic] = INVALID_VEHICLE_ID;
		}
		else
		{
			PlayerVehicle[i][pVehRental] = -1;
			PlayerVehicle[i][pVehRentTime] = 0;
			PlayerVehicle[i][pVehExists] = false;

			foreach(new pid : Player) if(PlayerVehicle[i][pVehOwnerID] == AccountData[pid][pID])
			{
				Info(pid, "Kendaaraanmu rental anda telah hancur. Anda dikenakan denda sebesar "GREEN"%s!", FormatMoney(PlayerVehicle[i][pVehPrice]/2));
				TakeMoney(pid, (PlayerVehicle[i][pVehPrice]/2));
			}

			if(IsValidVehicle(PlayerVehicle[i][pVehPhysic])) 
			{
				DestroyVehicle(PlayerVehicle[i][pVehPhysic]);
				PlayerVehicle[i][pVehPhysic] = INVALID_VEHICLE_ID;
			}

			new cQuery[200];
			mysql_format(g_SQL, cQuery, sizeof(cQuery), "DELETE FROM `player_vehicles` WHERE `id` = '%d'", PlayerVehicle[i][pVehID]);
			mysql_tquery(g_SQL, cQuery);

			Vehicle_ResetVariable(i);
			Iter_Remove(PvtVehicles, i);
		}
	}

	//ini untuk menghapus kendaraan yang dispawn oleh admin
	if(VehicleCore[vehicleid][vehAdmin])
	{
		DestroyVehicle(VehicleCore[vehicleid][vehAdminPhysic]);
		VehicleCore[vehicleid][vehAdminPhysic] = INVALID_VEHICLE_ID;
		VehicleCore[vehicleid][vehAdmin] = false;
	}
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	if(newstate)
	{
		SwitchVehicleLight(vehicleid, true);
		vehicleid = GetPlayerVehicleID(playerid);
		
		foreach(new i : PvtVehicles)
		{
			if(vehicleid == PlayerVehicle[i][pVehPhysic])
			{
				if(PlayerVehicle[i][pVehFaction] != FACTION_POLISI && PlayerVehicle[i][pVehFaction] != FACTION_EMS) 
					return 0;

				gToggleELM[vehicleid] = true;
				gELMTimer[vehicleid] = SetTimerEx("ToggleELM", 80, true, "d", vehicleid);
			}
		}
	}
	else 
	{
		static panels, doors, lights, tires;

		gToggleELM[vehicleid] = false;
		KillTimer(gELMTimer[vehicleid]);

		GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
		UpdateVehicleDamageStatus(vehicleid, panels, doors, 0, tires);
	}
	return 1;
}

hook OnVehicleCreated(vehicleid)
{
	TrunkVehEntered[vehicleid] = INVALID_PLAYER_ID;
	return 1;
}

hook OnVehicleDestroyed(vehicleid)
{
    new index = -1;
    // Pindahkan pengambilan playerid ke tempat yang aman
    new driverid = GetVehicleDriver(vehicleid);
	#pragma unused driverid

    if((index = Vehicle_GetID(vehicleid)) != -1)
    {
        if(PlayerVehicle[index][vehSirenOn])
        {
            PlayerVehicle[index][vehSirenOn] = false;
            if(IsValidDynamicObject(PlayerVehicle[index][vehSirenObject]))
            {
                DestroyDynamicObject(PlayerVehicle[index][vehSirenObject]);
                PlayerVehicle[index][vehSirenObject] = INVALID_STREAMER_ID;
            }
        }

        if(IsBagasiOpened[PlayerVehicle[index][pVehPhysic]])
        {
            IsBagasiOpened[PlayerVehicle[index][pVehPhysic]] = false;
        }

        if(TrunkVehEntered[PlayerVehicle[index][pVehPhysic]] != INVALID_PLAYER_ID)
        {
            new Float:x, Float:y, Float:z;
            GetVehicleBoot(vehicleid, x, y, z);
            PlayerSpectateVehicle(TrunkVehEntered[PlayerVehicle[index][pVehPhysic]], INVALID_VEHICLE_ID);

            SetSpawnInfo(TrunkVehEntered[PlayerVehicle[index][pVehPhysic]], 0, AccountData[TrunkVehEntered[PlayerVehicle[index][pVehPhysic]]][pSkin], x, y, z, 0.0, 0, 0, 0, 0, 0, 0);
            TogglePlayerSpectating(TrunkVehEntered[PlayerVehicle[index][pVehPhysic]], false);
            SetPVarInt(TrunkVehEntered[PlayerVehicle[index][pVehPhysic]], "PlayerInTrunk", 0);
            AccountData[TrunkVehEntered[PlayerVehicle[index][pVehPhysic]]][pTempVehID] = INVALID_VEHICLE_ID;
            TrunkVehEntered[PlayerVehicle[index][pVehPhysic]] = INVALID_PLAYER_ID;
        }

        for (new slot = 0; slot < MAX_VEHICLE_OBJECT; slot ++) if (VehicleObjects[index][slot][vehObjectExists])
        {
            if (VehicleObjects[index][slot][vehObject] != INVALID_STREAMER_ID)
                DestroyDynamicObject(VehicleObjects[index][slot][vehObject]);
            
            VehicleObjects[index][slot][vehObject] = INVALID_STREAMER_ID;
        }
        
        PlayerVehicle[index][pVehPhysic] = INVALID_VEHICLE_ID;
    }

    if(gToggleELM[vehicleid])
    {
        gToggleELM[vehicleid] = false;
        KillTimer(gELMTimer[vehicleid]);
    }

    // --- BAGIAN MIXER ---
    // Cek semua pemain untuk mencari apakah ada yang menggunakan kendaraan mixer ini
    foreach(new i : Player)
    {
        if(jobs::mixer[i][mixerVehicle] == vehicleid && vehicleid != INVALID_VEHICLE_ID)
        {
            CancelMixerJob(i, "Job mixer gagal kendaraan anda hancur!");
        }
    }

    foreach(new i : Player)
    {
        // Cek: Apakah pemain ini sedang duty (tahap 0) DAN apakah kendaraan yang meledak ini miliknya?
        if(jobs::mixer[i][mixerDuty][0] && jobs::mixer[i][mixerVehicle] == vehicleid)
        {
            // Panggil fungsi pembatalan secara penuh
            CancelMixerJob(i, "Pekerjaan Mixer gagal karena truk Anda hancur!");
        }
    }
    
    return 1;
}

stock CancelMixerJob(playerid, reason[])
{
    // Matikan Timer
    if(jobs::mixer[playerid][mixerTimer] != -1)
    {
        KillTimer(jobs::mixer[playerid][mixerTimer]);
        jobs::mixer[playerid][mixerTimer] = -1;
    }
    
    // Matikan SEMUA tahapan kerja secara paksa
    jobs::mixer[playerid][mixerDuty][0] = false;
    jobs::mixer[playerid][mixerDuty][1] = false;
    jobs::mixer[playerid][mixerDuty][2] = false;
    
    // Hapus kepemilikan kendaraan agar tidak nyangkut
    jobs::mixer[playerid][mixerVehicle] = INVALID_VEHICLE_ID;
    
    // Sembunyikan UI dan Checkpoint
    DisablePlayerCheckpoint(playerid);
    HideProgressBarNew(playerid);
    
    // Sembunyikan TextDraw Pekerjaan
    for (new i; i < 3; i++)
    {
        if (i < sizeof(jobs::GBMixer))
            TextDrawHideForPlayer(playerid, jobs::GBMixer[i]);
    }
    PlayerTextDrawHide(playerid, jobs::PBMixer[playerid]);
    
    // Panggil fungsi reset enum bawaan untuk double protection
    jobs::mixer_reset_enum(playerid);
    
    // Kirim peringatan
    SendClientMessage(playerid, 0xFF0000FF, reason); 
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(AccountData[playerid][pTogAutoEngine] && !IsABicycle(vehicleid))
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			if(GetEngineStatus(vehicleid)) 
			{
				AccountData[playerid][pTempVehID] = vehicleid;
				SetTimerEx("EngineTurnOff", 1500, false, "dd", playerid, vehicleid);
			}
		}
	}
	return 1;
}

forward EngineTurnOff(playerid, vehicleid);
public EngineTurnOff(playerid, vehicleid)
{
	if(AccountData[playerid][pTempVehID] == vehicleid)
	{
		SwitchVehicleEngine(vehicleid, false);
		SendRPMeAboveHead(playerid, "Mesin mati", X11_LIGHTGREEN);	
	
		AccountData[playerid][pTempVehID] = INVALID_VEHICLE_ID;
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
   	if((AccountData[playerid][pAdmin] >= 1 || AccountData[playerid][pTheStars] >= 1) && AccountData[playerid][pAdminDuty] == 1)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            SetVehiclePos(vehicleid, fX, fY, fZ+10);
        }
        else
        {
            SetPlayerPosFindZ(playerid, fX, fY, 999.0);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
        }
    }

	if(AccountData[playerid][pAdmin] >= 1 || AccountData[playerid][pTheStars] >= 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(vehicleid > 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			SetPVarFloat(playerid, "tpX", fX);
			SetPVarFloat(playerid, "tpY", fY);
			SetPVarFloat(playerid, "tpZ", fZ + 5.0);
		}
		else 
		{
			SetPVarFloat(playerid, "tpX", fX);
			SetPVarFloat(playerid, "tpY", fY);
			SetPVarFloat(playerid, "tpZ", fZ);
		}
	}
    return 1;
}

Dialog:DOKUMENT_MENU(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		return InfoMsg(playerid, "Anda telah membatalkan pilihan");
	}

	switch(listitem)
	{
		case 1: // lihat ktp
		{
			if(!AccountData[playerid][Ktp]) return ErrorMsg(playerid, "Anda tidak memiliki KTP!");
			// ShowKTPTD(playerid);
			DisplayNewKTP2(playerid, playerid, true);
		}
		case 2: // Tunjukan KTP
		{
			if(!AccountData[playerid][Ktp]) return ErrorMsg(playerid, "Anda tidak memiliki KTP!");
			foreach(new i : Player) if (IsPlayerConnected(i)) if (i != playerid)
			{
				if(IsPlayerNearPlayer(playerid, i, 3.0))
				{
					DisplayNewKTP2(playerid, i, true);
				}
			}
		}
		case 3: // Lihat SIM
		{
			DisplayLicensi(playerid, playerid);
		}
		case 4: // Tunjukan SIM
		{
			foreach(new i : Player) if (IsPlayerConnected(i)) if (i != playerid)
			{
				if(IsPlayerNearPlayer(playerid, i, 3.0))
				{
					DisplayLicensi(i, playerid);
				}
			}
		}
		case 5: // Lihat SKWB
		{
			if (!AccountData[playerid][pSKWB]) return ErrorMsg(playerid, "Anda tidak memiliki SKWB!");

			DisplaySKWB(playerid, playerid);
		}
		case 6: // tunjukan SKWB
		{
			if(!AccountData[playerid][pSKWB]) return ErrorMsg(playerid, "Anda tidak memiliki SKWB!");
			
			foreach(new i : Player) if (IsPlayerConnected(i))
			{
				if(IsPlayerNearPlayer(playerid, i, 3.0))
				{
					DisplaySKWB(playerid, i);
				}
			}
		}

		case 8: //lihat bpjs
		{
			if(!AccountData[playerid][pBPJS]) return ErrorMsg(playerid, "Anda tidak memiliki BPJS/Expired!");
			DisplayBPJS(playerid, playerid);
		}
		case 9: //tunjukan bpjs
		{
			if(!AccountData[playerid][pBPJS]) return ErrorMsg(playerid, "Anda tidak memiliki BPJS/Expired!");
			foreach(new i : Player) if (IsPlayerConnected(i)) if (i != playerid)
			{   
				if(IsPlayerNearPlayer(playerid, i, 3.0))
				{
					DisplayBPJS(i, playerid);
				}
			}
		}
		case 10: //lihat skck
		{
			if(!AccountData[playerid][pSKCK]) return ErrorMsg(playerid, "Anda tidak memiliki SKCK/Expired!");
			DisplaySKCK(playerid, playerid);
		}
		case 11: //tunjuk skck
		{
			if(!AccountData[playerid][pSKCK]) return ErrorMsg(playerid, "Anda tidak memiliki SKCK/Expired!");
			foreach(new i : Player) if (IsPlayerConnected(i)) if (i != playerid)
			{   
				if(IsPlayerNearPlayer(playerid, i, 3.0))
				{
					DisplaySKCK(i, playerid);
				}
			}
		}
		case 12: //lihat sks
		{
			if(!AccountData[playerid][pSKS]) return ErrorMsg(playerid, "Anda tidak memiliki Surat Keterangan Sehat/Expired!");
			DisplaySKS(playerid, playerid);
		}
		case 13: //tunjuk sks
		{
			if(!AccountData[playerid][pSKS]) return ErrorMsg(playerid, "Anda tidak memiliki Surat Keterangan Sehat/Expired!");
			foreach(new i : Player) if (IsPlayerConnected(i)) if (i != playerid)
			{   
				if(IsPlayerNearPlayer(playerid, i, 3.0))
				{
					DisplaySKS(i, playerid);
				}
			}
		}
	}
	return 1;
}

public OnClickDynamicTextDraw(playerid, Text:textid)
{
    if(textid == ui_actionclick[1] && KeyAction[playerid][isActive]) {
        OnProceedKeyAction(playerid);
    }
    
    if(textid == ui_vehiclemenu[6]) // Close Panel
	{
        for(new i = 0; i < 38; i++) TextDrawHideForPlayer(playerid, ui_vehiclemenu[i]);
        CancelSelectTextDraw(playerid);
        
        // Pindahkan fungsi pemunculan HUD Lapar/Haus ke sini agar aktif saat panel ditutup
        for(new x = 0; x < 5; x++) PlayerTextDrawShow(playerid, HbePNew[playerid][x]);
		for(new x = 0; x < 22; x++) TextDrawShowForPlayer(playerid, HbeGNew[x]);
	}

	if(textid == ui_vehiclemenu[5]) // Tombol Mesin Kendaraan
    {
        callcmd::en(playerid, "");

        new vehid = GetPlayerVehicleID(playerid);
        new engine, lights, alarm, doors, bonnet, boot, objective;
        GetVehicleParamsEx(vehid, engine, lights, alarm, doors, bonnet, boot, objective);

        if(engine == VEHICLE_PARAMS_ON)
        {
            ShowVehicleSpeedoOnly(playerid); 
            SendClientMessage(playerid, -1, "{00FF00}[VEHICLE] Mesin aktif. Speedometer dinyalakan.");
        }
        
        for(new i = 0; i < 38; i++) TextDrawHideForPlayer(playerid, ui_vehiclemenu[i]);
        CancelSelectTextDraw(playerid); // Matikan kursor mouse agar bisa langsung gas mobil
        
        // Munculkan kembali HUD Lapar/Haus saat menyetir
        for(new x = 0; x < 5; x++) PlayerTextDrawShow(playerid, HbePNew[playerid][x]);
		for(new x = 0; x < 22; x++) TextDrawShowForPlayer(playerid, HbeGNew[x]);
    }

	if(textid == ui_vehiclemenu[3]) // Trunk
	{
		new vehid = GetPlayerVehicleID(playerid);
        switch (GetTrunkStatus(vehid))
        {
            case false: SwitchVehicleBoot(vehid, true);
            case true: SwitchVehicleBoot(vehid, false);
        }
	}
    
	if(textid == ui_vehiclemenu[4]) // Hood
	{
		new vehid = GetPlayerVehicleID(playerid);
        switch (GetHoodStatus(vehid))
        {
            case false: SwitchVehicleBonnet(vehid, true);
            case true: SwitchVehicleBonnet(vehid, false);
        }
	}
    
	if(textid == ui_vehiclemenu[7]) // Lampu
	{	
		new vehid = GetPlayerVehicleID(playerid);
        if(!IsEngineVehicle(vehid)) return ErrorMsg(playerid, "Kendaraan ini bukan kendaraan bermesin!");

        new lightstatus = GetLightStatus(vehid);
        foreach(new i : PvtVehicles)
        {
            if(vehid == PlayerVehicle[i][pVehPhysic])
            {
                if(lightstatus)
                {
                    if(PlayerVehicle[i][pVehNeon] > 0)
                    {
                        SetVehicleNeonLights(PlayerVehicle[i][pVehPhysic], false, PlayerVehicle[i][pVehNeon], 0);
                    }
                }
                else 
                {
                    if(PlayerVehicle[i][pVehNeon] > 0)
                    {
                        SetVehicleNeonLights(PlayerVehicle[i][pVehPhysic], true, PlayerVehicle[i][pVehNeon], 0);
                    }
                }
            }
        }
        SwitchVehicleLight(vehid, !lightstatus);
	}
    
	if(textid == ui_vehiclemenu[13]) // Kaca Depan kiri
	{	
	    new kdkiri, kdkanan, kbkiri, kbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarWindows(vid, kdkiri, kdkanan, kbkiri, kbkanan);
	    if(kdkiri == 1) SetVehicleParamsCarWindows(vid, 0, kdkanan, kbkiri, kbkanan);
		else SetVehicleParamsCarWindows(vid, 1, kdkanan, kbkiri, kbkanan);
	}
    
	if(textid == ui_vehiclemenu[12]) // Kaca Depan Kanan
	{	
	    new kdkiri, kdkanan, kbkiri, kbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarWindows(vid, kdkiri, kdkanan, kbkiri, kbkanan);
	    if(kdkanan == 1) SetVehicleParamsCarWindows(vid, kdkiri, 0, kbkiri, kbkanan);
		else SetVehicleParamsCarWindows(vid, kdkiri, 1, kbkiri, kbkanan);
	}
    
	if(textid == ui_vehiclemenu[15]) // Kaca Belakang Kiri
	{	
	    new kdkiri, kdkanan, kbkiri, kbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarWindows(vid, kdkiri, kdkanan, kbkiri, kbkanan);
	    if(kbkiri == 1) SetVehicleParamsCarWindows(vid, kdkiri, kdkanan, 0, kbkanan);
		else SetVehicleParamsCarWindows(vid, kdkiri, kdkanan, 1, kbkanan);
	}
    
	if(textid == ui_vehiclemenu[14]) // Kaca Belakang Kanan
	{	
	    new kdkiri, kdkanan, kbkiri, kbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarWindows(vid, kdkiri, kdkanan, kbkiri, kbkanan);
	    if(kbkanan == 1) SetVehicleParamsCarWindows(vid, kdkiri, kdkanan, kbkiri, 0);
		else SetVehicleParamsCarWindows(vid, kdkiri, kdkanan, kbkiri, 1);
	}
    
	if(textid == ui_vehiclemenu[16]) // Pintu Depan Kiri
	{	
	    new pdkiri, pdkanan, pbkiri, pbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarDoors(vid, pdkiri, pdkanan, pbkiri, pbkanan);
   		if(pdkiri == 1) SetVehicleParamsCarDoors(vid, 0, pdkanan, pbkiri, pbkanan);
		else SetVehicleParamsCarDoors(vid, 1, pdkanan, pbkiri, pbkanan);
	}
    
	if(textid == ui_vehiclemenu[19]) // Pintu Depan Kanan
	{	
	    new pdkiri, pdkanan, pbkiri, pbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarDoors(vid, pdkiri, pdkanan, pbkiri, pbkanan);
	    if(pdkanan == 1) SetVehicleParamsCarDoors(vid, pdkiri, 0, pbkiri, pbkanan);
		else SetVehicleParamsCarDoors(vid, pdkiri, 1, pbkiri, pbkanan);
	}
    
	if(textid == ui_vehiclemenu[17]) // Pintu Belakang kiri
	{	
	    new pdkiri, pdkanan, pbkiri, pbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarDoors(vid, pdkiri, pdkanan, pbkiri, pbkanan);
	    if(pbkiri == 1) SetVehicleParamsCarDoors(vid, pdkiri, pdkanan, 0, pbkanan);
		else SetVehicleParamsCarDoors(vid, pdkiri, pdkanan, 1, pbkanan);
	}
    
	if(textid == ui_vehiclemenu[18]) // Pintu Belakang Kanan
	{	
	    new pdkiri, pdkanan, pbkiri, pbkanan;
	    new vid = GetPlayerVehicleID(playerid);
	    GetVehicleParamsCarDoors(vid, pdkiri, pdkanan, pbkiri, pbkanan);
	    if(pbkanan == 1) SetVehicleParamsCarDoors(vid, pdkiri, pdkanan, pbkiri, 0);
		else SetVehicleParamsCarDoors(vid, pdkiri, pdkanan, pbkiri, 1);
	}
    
	if(textid == ui_vehiclemenu[10]) // Seat Pengemudi
	{	
		new vehid = GetPlayerVehicleID(playerid);
		new seatid = GetAvailableSeat(vehid, 0);
        if(seatid == -1) return Error(playerid, "Bangku ini telah di isi");
		ActPutPlayerInVehicle(playerid, vehid, seatid);
	}
    
	if(textid == ui_vehiclemenu[9]) // Seat 2
	{	
		new vehid = GetPlayerVehicleID(playerid);
	    new seatid = GetAvailableSeat(vehid, 1);
        if(GetVehicleMaxSeats(vehid) < 2) return Error(playerid, "Max kursi kendaraan 1.");
        if(seatid == -1) return Error(playerid, "Bangku ini telah di isi");
		ActPutPlayerInVehicle(playerid, vehid, seatid);
	}
    
	if(textid == ui_vehiclemenu[11]) // Seat 3
	{	
		new vehid = GetPlayerVehicleID(playerid);
	    new seatid = GetAvailableSeat(vehid, 2);
        if(GetVehicleMaxSeats(vehid) < 3) return Error(playerid, "Tidak bisa.");
        if(seatid == -1) return Error(playerid, "Bangku ini telah di isi");
		ActPutPlayerInVehicle(playerid, vehid, seatid);
	}
    
	if(textid == ui_vehiclemenu[8]) // Seat 4
	{	
		new vehid = GetPlayerVehicleID(playerid);
	    new seatid = GetAvailableSeat(vehid, 3);
        if(GetVehicleMaxSeats(vehid) < 3) return Error(playerid, "Tidak bisa.");
        if(seatid == -1) return Error(playerid, "Bangku ini telah di isi");
		ActPutPlayerInVehicle(playerid, vehid, seatid);
	}
	return 1;
}
// Taruh kode ini di paling bawah Main.pwn (Pastikan ditaruh di luar fungsi callback manapun!)
forward ShowVehicleSpeedoOnly(playerid);
public ShowVehicleSpeedoOnly(playerid)
{
    // Mengaktifkan TextDraw speedometer bulat dari array ui_vehiclemenu
    for(new i = 20; i < 38; i++)
    {
        TextDrawShowForPlayer(playerid, ui_vehiclemenu[i]);
    }
    return 1;
}

public OnClickDynamicPlayerTextDraw(playerid, PlayerText: textid)
{
	//job mixer

	//innventory
	if(textid == inv::textdraw[playerid][60])//close
	{
		Inventory_Close(playerid);
	}
	if(textid == inv::textdraw[playerid][56])//amount
	{
		if(AccountData[playerid][pSelectItem] == -1) return WarningMsg(playerid, "Anda belum memilih item!");
		ShowPlayerDialog(playerid, DIALOG_SETAMOUNT, DIALOG_STYLE_INPUT, ""JAVA"KARSA "WHITE"- Set Amount",
		"Mohon masukkan berapa jumlah item yang akan diberikan:", "Set", "Batal");
	}
	if(textid == inv::textdraw[playerid][57])//use
	{
		new
			itemid = AccountData[playerid][pSelectItem],
			string[64];

		if(AccountData[playerid][pSelectItem] == -1) return WarningMsg(playerid, "Anda belum memilih barang!");
		strunpack(string, InventoryData[playerid][itemid][invItem]);
			
		if(ItemCantUse(string)) return ErrorMsg(playerid, "Item tersebut tidak bisa digunakan!");
		OnPlayerUseItem(playerid, itemid, string);
	}
	if(textid == inv::textdraw[playerid][58])//give
	{
		if(AccountData[playerid][pSelectItem] == -1) return WarningMsg(playerid, "Anda belum memilih barang!");
		if(AccountData[playerid][pAmountInv] == 0) return WarningMsg(playerid, "Anda belum input jumlah yang akan diberikan!");
		
		new frmxt[355], string[512];
		strunpack(string, InventoryData[playerid][AccountData[playerid][pSelectItem]][invItem]);
		

		if(!strcmp(string, "Sampah Makanan"))
			return ErrorMsg(playerid, "Tidak dapat memberikan sampah kepada orang lain!");
		
		if(!strcmp(string, "Boombox"))
			return ErrorMsg(playerid, "Tidak dapat memberikan Boombox kepada orang lain!");

		new count = 0;
		foreach(new i : Player) if(i != playerid) if(IsPlayerNearPlayer(playerid, i, 2.5))
		{
			format(frmxt, sizeof(frmxt), "%sPlayer ID: %d\n", frmxt, i);
			NearestPlayer[playerid][count++] = i;
		}
		
		if(count == 0)
		{
			PlayerPlaySound(playerid, 5206, 0.0, 0.0, 0.0);
			Inventory_Close(playerid);
			return ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""JAVA"KARSA "WHITE"- Give Item",
			"Tidak ada player yang dekat dengan anda!", "Tutup", "");
		}

		ShowPlayerDialog(playerid, DIALOG_MEMBERI, DIALOG_STYLE_LIST, ""JAVA"KARSA "WHITE"- Give Item", frmxt, "Pilih", "Close");
	}
	if(textid == inv::textdraw[playerid][59])//drop
	{
		if(AccountData[playerid][pSelectItem] < 0) return WarningMsg(playerid, "Anda belum memilih barang!");
		if(AccountData[playerid][pAmountInv] == 0) return WarningMsg(playerid, "Anda belum menentukan jumlah barang!");
		if(AccountData[playerid][ActivityTime] != 0) return WarningMsg(playerid, "Anda sedang melakukan sesuatu, tunggu hingga progress selesai!");
		
		new itemid = AccountData[playerid][pSelectItem],
			amount = AccountData[playerid][pAmountInv],
			model = InventoryData[playerid][AccountData[playerid][pSelectItem]][invModel],
			string[ 256 ];
		
		strunpack(string, InventoryData[playerid][itemid][invItem]);
		
		new trash_nearest = TrashNearest(playerid);
		if(trash_nearest != -1)
		{
			if(amount < 1) return ErrorMsg(playerid, "Jumlah tidak valid!");
			if(amount > InventoryData[playerid][AccountData[playerid][pSelectItem]][invQuantity]) return ErrorMsg(playerid, sprintf("Anda tidak memiliki %s sebanyak itu!", string));
			Inventory_Remove(playerid, string, amount);
			Inventory_Close(playerid);
			ShowItemBox(playerid, sprintf("Removed %dx", amount), string, model);
			ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1);

			SendRPMeAboveHead(playerid, sprintf("Membuang %d %s miliknya ke tong sampah", amount, string), X11_PLUM1);
		}
		else if(IsPeleburanArea(playerid))
		{
			if(AccountData[playerid][pFaction] != FACTION_POLISI) return ErrorMsg(playerid, "Anda bukan anggota kepolisian!");
			if(AccountData[playerid][pInjured]) return ErrorMsg(playerid, "Anda sedang pingsan!");
			if(amount < 1 || amount > InventoryData[playerid][AccountData[playerid][pSelectItem]][invQuantity]) return ErrorMsg(playerid, "Jumlah tidak valid!");

			Inventory_Remove(playerid, string, amount);
			Inventory_Close(playerid);
			ShowItemBox(playerid, sprintf("Removed %dx", amount), string, model);
			ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1);
			
			SendRPMeAboveHead(playerid, sprintf("Melempar %d %s ke tempat peleburan", amount, string), X11_PLUM1);
		}
		else
		{
			if(!strcmp(string, "Sampah Makanan"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang sampah sembarangan!");
				return 1;
			}
			else if(!strcmp(string, "Hiu"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Penyu"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Kayu"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Kayu Potongan"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Ayam Hidup"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Ayam Potongan"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Bulu"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Boxmats"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Pancingan"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Umpan"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Batu Kotor"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Batu Bersih"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Petrol"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}
			else if(!strcmp(string, "Pure Oil"))
			{
				ErrorMsg(playerid, "Tidak dapat membuang item ini!");
				return 1;
			}

			if(amount < 1) return ErrorMsg(playerid, "Jumlah input tidak valid!");
			if(amount > InventoryData[playerid][itemid][invQuantity]) return ErrorMsg(playerid, sprintf("Anda tidak memiliki %s sebanyak itu!", string));
			
			if(!strcmp(string, "Radio", true))
			{
				if(ToggleRadio[playerid] || RadioMicOn[playerid])
				{
					ToggleRadio[playerid] = false;
					RadioMicOn[playerid] = false;
					CallRemoteFunction("UpdatePlayerVoiceMicToggle", "dd", playerid, false);
					CallRemoteFunction("UpdatePlayerVoiceRadioToggle", "dd", playerid, false);
					CallRemoteFunction("AssignFreqToFSVoice", "ddd", playerid, true, 0);
					PlayerTextDrawSetString(playerid, ATRP_RadioTD[playerid][7], "0");
				}
			}
			DropPlayerItem(playerid, itemid, amount);
		}
	}
	for(new i = 0; i < MAX_BOX_REMEMBERED; i++) if(textid == ui_box_minigamerob[playerid][i])
	{
		if(BoxMiniGameRobbery[playerid][i][BoxClicked] && MiniGameRobbery[playerid][StartMiniGame])
		{
			PlayerTextDrawColor(playerid, ui_box_minigamerob[playerid][i], X11_BLACK);
			PlayerTextDrawShow(playerid, ui_box_minigamerob[playerid][i]);
            MiniGameRobbery[playerid][CountBoxClicked] ++;

			if(MiniGameRobbery[playerid][CountBoxClicked] == MAX_RANDOM_CLICK) 
            {
                if(MiniGameRobbery[playerid][CallbackMiniGameRobbery][0] != EOS) 
                {
                    CallLocalFunction(MiniGameRobbery[playerid][CallbackMiniGameRobbery], "dd", playerid, 1);
                    MiniGameRobberys(playerid, false);

                    MessageBox_MiniGameRobberys(playerid, "Successfully hacks...");
                    defer HideMessageBox(playerid);
                }
            }
		}
		else if (MiniGameRobbery[playerid][StartMiniGame])
        {
            MiniGameRobberys(playerid, false);
            MessageBox_MiniGameRobberys(playerid, "Failed to hacks...");
            defer HideMessageBox(playerid);

            SendRPMeAboveHead(playerid, "Gagal hack ATM", X11_PLUM);
                    
            ClearAnimations(playerid, 1);
            CallLocalFunction(MiniGameRobbery[playerid][CallbackMiniGameRobbery], "dd", playerid, 0);
        }
	}

    if(textid == ui_racetablet[playerid][37]) {
        ShowRacePlayerMenu(playerid);
    }
    if(textid == ui_racetablet[playerid][35]) {
        if(AccountData[playerid][pRaceWith] == INVALID_PLAYER_ID)
            return Error(playerid, "Kamu tidak berada pada balapan manapun.");

        if(RaceInfo[playerid][raceStarted])
            return Error(playerid, "Kamu tidak bisa keluar pada balapanmu sendiri!");

        RaceInfo[AccountData[playerid][pRaceWith]][racePrize] -= 100;
        Race_ResetPlayer(playerid);
        SendClientMessageEx(playerid, X11_LIMEGREEN, "[Race]: "WHITE"Kamu telah keluar dari balapan.");
        RemovePlayerMapIcon(playerid, 97);
    }
    if(textid == ui_racetablet[playerid][29]) {
        HideRaceTablet(playerid);
        SetPVarInt(playerid, "TabletBikinTrack", 1);

        if(!AccountData[playerid][pCheckpointEditing]) {
            AccountData[playerid][pCurrentCheckpointIndex] = 0;
            AccountData[playerid][pCheckpointEditing] = true;
            Info(playerid, "Checkpoint mode active! gunakan /setcp lagi untuk nonaktif.");
            Info(playerid, "Tekan "YELLOW"LMB "WHITE"didalam kendaraan untuk set- CP.");
        } else {
            AccountData[playerid][pCheckpointEditing] = false;
            Info(playerid, "Checkpoint mode deactivated.");
        }

        SendClientMessageEx(playerid, X11_RED, "[Race System] "WHITE"Silahkan gunakan "YELLOW"/race setcp "WHITE"jika sudah set-checkpoint.");
        SendClientMessageEx(playerid, X11_RED, "[Race System] "WHITE"Jika ingin setting "CYAN"Finish Point "WHITE"Gunakan "YELLOW"/race finish");
        SendClientMessageEx(playerid, X11_RED, "[Race System] "WHITE"Untuk save track ke Database, gunakan "YELLOW"/race save");
        SendClientMessageEx(playerid, X11_RED, "[Race System] "WHITE"Untuk me-reset Checkpoint yang telah di-set, gunakan "YELLOW"/race resetcp");
    }
    if(textid == ui_racetablet[playerid][33]) {
        mysql_tquery(g_SQL, "SELECT * FROM `race_list`", "OnLoadRaceCheck", "d", playerid);
    }
    if(textid == ui_racetablet[playerid][25]) {
        HideRaceTablet(playerid);
    }
    if(textid == ui_racetablet[playerid][31]) {
        mysql_tquery(g_SQL, sprintf("SELECT * FROM `player_characters` WHERE `Char_RaceMMR` > '0' ORDER BY `Char_RaceMMR` DESC LIMIT 10;"), "OnRaceLeaderboard", "d", playerid);
    }
    if(textid == ui_racetablet[playerid][40]) {
        Dialog_Show(playerid, CariRace, DIALOG_STYLE_INPUT, ""JAVA""SERVER_NAME""WHITE" - Search", "Masukkan nama map/track yang ingin anda gunakan:", "Cari", "Close");
    }
	if(textid == ui_racetablet[playerid][34]) {
        mysql_tquery(g_SQL, "SELECT * FROM `race_list`", "OnLoadRaceCheck", "d", playerid);
    }
    if(textid == ui_racetablet[playerid][30]) {
        for(new i = 0; i < 46; i++) {
            PlayerTextDrawHide(playerid, ui_racetablet[playerid][i]);
        }
        CancelSelectTextDraw(playerid);
    }
    if(textid == ui_racetablet[playerid][39]) {
        Dialog_Show(playerid, NoneDialog, DIALOG_STYLE_MSGBOX, "Info", "Coming Soon", "Close", "");
    }
	if(textid == jobs::Pmixer[playerid][5])
	{
		jobs::mixer_select_case(playerid, 1);
	}
	if(textid == jobs::Pmixer[playerid][6])
	{
		jobs::mixer_select_case(playerid, 2);
	}
	if(textid == jobs::Pmixer[playerid][7])
	{
		jobs::mixer_select_case(playerid, 3);
	}
	if(textid == jobs::Pmixer[playerid][8])
	{
		jobs::mixer_select_case(playerid, 4);
	}
	if(textid == jobs::Pmixer[playerid][9])
	{
		jobs::mixer_select_case(playerid, 5);
	}
	if(textid == jobs::Pmixer[playerid][10])//confirm
	{
		jobs::mixer_confirm(playerid);
	}

	//showroom
	new showroomID = GetPVarInt(playerid, "SelectShowroomID");
    if(textid == ATRP_ShowroomTD[playerid][11]) // Next Veh
    {
        if(showroomID != 0)
        {
            if(showroomID == 1) // Truk
            {
                if(SelectVeh[playerid] == sizeof(TrukShowroom) - 1)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] ++;
                VehicleTruckSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(TrukShowroom[SelectVeh[playerid]]), FormatMoney(TrukCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 2) // Suv
            {
                if(SelectVeh[playerid] == sizeof(SuvShowroom) - 1)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] ++;
                VehicleSuvSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(SuvShowroom[SelectVeh[playerid]]), FormatMoney(SuvCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 3) // Motor
            {
                if(SelectVeh[playerid] == sizeof(MotorShowroom) - 1)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] ++;
                VehicleMotorSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(MotorShowroom[SelectVeh[playerid]]), FormatMoney(MotorCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 4) // Low ride
            {
                if(SelectVeh[playerid] == sizeof(ClassicShowroom) - 1)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] ++;
                VehicleLowriderSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(ClassicShowroom[SelectVeh[playerid]]), FormatMoney(ClassicCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 5) // Compact
            {
                if(SelectVeh[playerid] == sizeof(CompactShowroom) - 1)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] ++;
                VehicleCompactSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(CompactShowroom[SelectVeh[playerid]]), FormatMoney(CompactCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 6) // Luxury
            {
                if(SelectVeh[playerid] == sizeof(LuxuryShowroom) - 1)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] ++;
                VehicleLuxurySelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(LuxuryShowroom[SelectVeh[playerid]]), FormatMoney(LuxuryCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
        }
    }
    else if(textid == ATRP_ShowroomTD[playerid][10]) // Previous veh
    {
        if(showroomID != 0)
        {
            if(showroomID == 1) // truk
            {
                if(SelectVeh[playerid] == 0)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] --;
                VehicleTruckSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(TrukShowroom[SelectVeh[playerid]]), FormatMoney(TrukCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 2) // Suv
            {
                if(SelectVeh[playerid] == 0)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] --;
                VehicleSuvSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(SuvShowroom[SelectVeh[playerid]]), FormatMoney(SuvCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 3) // Motor
            {
                if(SelectVeh[playerid] == 0)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] --;
                VehicleMotorSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(MotorShowroom[SelectVeh[playerid]]), FormatMoney(MotorCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 4) // Lowrider
            {
                if(SelectVeh[playerid] == 0)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] --;
                VehicleLowriderSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(ClassicShowroom[SelectVeh[playerid]]), FormatMoney(ClassicCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 5) // Compact
            {
                if(SelectVeh[playerid] == 0)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] --;
                VehicleCompactSelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(CompactShowroom[SelectVeh[playerid]]), FormatMoney(CompactCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
            else if(showroomID == 6) // Luxury
            {
                if(SelectVeh[playerid] == 0)
                {
                    PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
                    return 0;
                }
                else SelectVeh[playerid] --;
                VehicleLuxurySelect(playerid);

                PlayerTextDrawSetString(playerid, ATRP_ShowroomTD[playerid][14], sprintf("%s~n~~g~%s", GetVehicleModelName(LuxuryShowroom[SelectVeh[playerid]]), FormatMoney(LuxuryCost(playerid))));
                PlayerTextDrawShow(playerid, ATRP_ShowroomTD[playerid][14]);
            }
        }
    }
    else if(textid == ATRP_ShowroomTD[playerid][13]) // Keluar Showroom
    {
        EnableAntiCheatForPlayer(playerid, 4, true);
        DestroyVehicle(ShowroomVeh[playerid]);
        ShowroomVeh[playerid] = INVALID_VEHICLE_ID;

        SetPlayerPositionEx(playerid, -1958.41, 303.64, 35.46, 320.86, 1500);
        SetPlayerVirtualWorld(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPVarInt(playerid, "SelectShowroomID", 0);
        SelectVeh[playerid] = 0;
        CancelSelectTextDraw(playerid);
        Toggle_ShowroomTD(playerid, false);
		for(new x = 0; x < 5; x++) PlayerTextDrawShow(playerid, HbePNew[playerid][x]);
		for(new x = 0; x < 22; x++) TextDrawShowForPlayer(playerid, HbeGNew[x]);
		for(new x = 0; x < 5; x++) PlayerTextDrawHide(playerid, HbePNew[playerid][x]);
		for(new x = 0; x < 22; x++) TextDrawHideForPlayer(playerid, HbeGNew[x]);
    }
    else if(textid == ATRP_ShowroomTD[playerid][12]) // Buy
    {
        if(showroomID != 0)
        {
            if(showroomID == 1) // Truk
            {
                new count = 0, modelid = TrukShowroom[SelectVeh[playerid]], cost = TrukCost(playerid);
                if(modelid <= 0) return ErrorMsg(playerid, "Model ID Kendaraan tidak valid!");
                if(AccountData[playerid][pMoney] < cost) return ErrorMsg(playerid, "Uang anda tidak mencukupi!");
                foreach(new iter : PvtVehicles) if (PlayerVehicle[iter][pVehExists])
                {
                    if(PlayerVehicle[iter][pVehOwnerID] == AccountData[playerid][pID])
                    {
                        count ++;
                    }
                }

                if(count >= GetPlayerVehicleLimit(playerid)) return WarningMsg(playerid, "Slot kendaraan anda sudah penuh!");
                SuccesMsg(playerid, "Pembelian berhasil dilakukan.");
                TakeMoney(playerid, cost);
                ShowroomVehicle_Create(playerid, modelid, -1980.64, 250.00, 35.17, 0.24, random(255), random(255), cost);
                static shstr[128];
                format(shstr, sizeof(shstr), "Membeli kendaraan %s seharga %s", GetVehicleModelName(modelid), FormatMoney(cost));
                AddPMoneyLog(AccountData[playerid][pName], AccountData[playerid][pUCP], shstr, cost);
                
                Toggle_ShowroomTD(playerid, false);
                SetPVarInt(playerid, "SelectShowroomID", 0);
                SelectVeh[playerid] = 0;
            }
            else if(showroomID == 2) // Suv
            {
                new count = 0, modelid = SuvShowroom[SelectVeh[playerid]], cost = SuvCost(playerid);
                if(modelid <= 0) return ErrorMsg(playerid, "Model ID Kendaraan tidak valid!");
                if(AccountData[playerid][pMoney] < cost) return ErrorMsg(playerid, "Uang anda tidak mencukupi!");
                foreach(new iter : PvtVehicles) if (PlayerVehicle[iter][pVehExists])
                {
                    if(PlayerVehicle[iter][pVehOwnerID] == AccountData[playerid][pID])
                    {
                        count ++;
                    }
                }

                if(count >= GetPlayerVehicleLimit(playerid)) return WarningMsg(playerid, "Slot kendaraan anda sudah penuh!");
                SuccesMsg(playerid, "Pembelian berhasil dilakukan.");
                TakeMoney(playerid, cost);
                ShowroomVehicle_Create(playerid, modelid, -1980.64, 250.00, 35.17, 0.24, random(255), random(255), cost);
                static shstr[128];
                format(shstr, sizeof(shstr), "Membeli kendaraan %s seharga %s", GetVehicleModelName(modelid), FormatMoney(cost));
                AddPMoneyLog(AccountData[playerid][pName], AccountData[playerid][pUCP], shstr, cost);
                
                Toggle_ShowroomTD(playerid, false);
                SetPVarInt(playerid, "SelectShowroomID", 0);
                SelectVeh[playerid] = 0;
            }
            else if(showroomID == 3) // Motor
            {
                new count = 0, modelid = MotorShowroom[SelectVeh[playerid]], cost = MotorCost(playerid);
                if(modelid <= 0) return ErrorMsg(playerid, "Model ID Kendaraan tidak valid!");
                if(AccountData[playerid][pMoney] < cost) return ErrorMsg(playerid, "Uang anda tidak mencukupi!");
                foreach(new iter : PvtVehicles) if (PlayerVehicle[iter][pVehExists])
                {
                    if(PlayerVehicle[iter][pVehOwnerID] == AccountData[playerid][pID])
                    {
                        count ++;
                    }
                }

                if(count >= GetPlayerVehicleLimit(playerid)) return WarningMsg(playerid, "Slot kendaraan anda sudah penuh!");
                SuccesMsg(playerid, "Pembelian berhasil dilakukan.");
                TakeMoney(playerid, cost);
                ShowroomVehicle_Create(playerid, modelid, -1980.64, 250.00, 35.17, 0.24, random(255), random(255), cost);
                static shstr[128];
                format(shstr, sizeof(shstr), "Membeli kendaraan %s seharga %s", GetVehicleModelName(modelid), FormatMoney(cost));
                AddPMoneyLog(AccountData[playerid][pName], AccountData[playerid][pUCP], shstr, cost);
                
                Toggle_ShowroomTD(playerid, false);
                SetPVarInt(playerid, "SelectShowroomID", 0);
                SelectVeh[playerid] = 0;
            }
            else if(showroomID == 4) // Low
            {
                new count = 0, modelid = ClassicShowroom[SelectVeh[playerid]], cost = ClassicCost(playerid);
                if(modelid <= 0) return ErrorMsg(playerid, "Model ID Kendaraan tidak valid!");
                if(AccountData[playerid][pMoney] < cost) return ErrorMsg(playerid, "Uang anda tidak mencukupi!");
                foreach(new iter : PvtVehicles) if (PlayerVehicle[iter][pVehExists])
                {
                    if(PlayerVehicle[iter][pVehOwnerID] == AccountData[playerid][pID])
                    {
                        count ++;
                    }
                }

                if(count >= GetPlayerVehicleLimit(playerid)) return WarningMsg(playerid, "Slot kendaraan anda sudah penuh!");
                SuccesMsg(playerid, "Pembelian berhasil dilakukan.");
                TakeMoney(playerid, cost);
                ShowroomVehicle_Create(playerid, modelid, -1980.64, 250.00, 35.17, 0.24, random(255), random(255), cost);
                static shstr[128];
                format(shstr, sizeof(shstr), "Membeli kendaraan %s seharga %s", GetVehicleModelName(modelid), FormatMoney(cost));
                AddPMoneyLog(AccountData[playerid][pName], AccountData[playerid][pUCP], shstr, cost);
                
                Toggle_ShowroomTD(playerid, false);
                SetPVarInt(playerid, "SelectShowroomID", 0);
                SelectVeh[playerid] = 0;
            }
            else if(showroomID == 5) // Compact
            {
                new count = 0, modelid = CompactShowroom[SelectVeh[playerid]], cost = CompactCost(playerid);
                if(modelid <= 0) return ErrorMsg(playerid, "Model ID Kendaraan tidak valid!");
                if(AccountData[playerid][pMoney] < cost) return ErrorMsg(playerid, "Uang anda tidak mencukupi!");
                foreach(new iter : PvtVehicles) if (PlayerVehicle[iter][pVehExists])
                {
                    if(PlayerVehicle[iter][pVehOwnerID] == AccountData[playerid][pID])
                    {
                        count ++;
                    }
                }

                if(count >= GetPlayerVehicleLimit(playerid)) return WarningMsg(playerid, "Slot kendaraan anda sudah penuh!");
                SuccesMsg(playerid, "Pembelian berhasil dilakukan.");
                TakeMoney(playerid, cost);
                ShowroomVehicle_Create(playerid, modelid, -1980.64, 250.00, 35.17, 0.24, random(255), random(255), cost);
                static shstr[128];
                format(shstr, sizeof(shstr), "Membeli kendaraan %s seharga %s", GetVehicleModelName(modelid), FormatMoney(cost));
                AddPMoneyLog(AccountData[playerid][pName], AccountData[playerid][pUCP], shstr, cost);
                
                Toggle_ShowroomTD(playerid, false);
                SetPVarInt(playerid, "SelectShowroomID", 0);
                SelectVeh[playerid] = 0;
            }
            else if(showroomID == 6) // Luxury
            {
                new count = 0, modelid = LuxuryShowroom[SelectVeh[playerid]], cost = LuxuryCost(playerid);
                if(modelid <= 0) return ErrorMsg(playerid, "Model ID Kendaraan tidak valid!");
                if(AccountData[playerid][pMoney] < cost) return ErrorMsg(playerid, "Uang anda tidak mencukupi!");
                foreach(new iter : PvtVehicles) if (PlayerVehicle[iter][pVehExists])
                {
                    if(PlayerVehicle[iter][pVehOwnerID] == AccountData[playerid][pID])
                    {
                        count ++;
                    }
                }

                if(count >= GetPlayerVehicleLimit(playerid)) return WarningMsg(playerid, "Slot kendaraan anda sudah penuh!");
                SuccesMsg(playerid, "Pembelian berhasil dilakukan.");
                TakeMoney(playerid, cost);
                ShowroomVehicle_Create(playerid, modelid, -1980.64, 250.00, 35.17, 0.24, random(255), random(255), cost);
                static shstr[128];
                format(shstr, sizeof(shstr), "Membeli kendaraan %s seharga %s", GetVehicleModelName(modelid), FormatMoney(cost));
                AddPMoneyLog(AccountData[playerid][pName], AccountData[playerid][pUCP], shstr, cost);
                
                Toggle_ShowroomTD(playerid, false);
                SetPVarInt(playerid, "SelectShowroomID", 0);
                SelectVeh[playerid] = 0;
            }
        }
    }
	//radio
	if(textid == ATRP_RadioTD[playerid][10]) //set freq
    {   
        ShowPlayerDialog(playerid, DIALOG_RADIO_FREQ, DIALOG_STYLE_INPUT, ""JAVA"KARSA "WHITE"- Radio Fx",
        "Masukkan frekuensi radio yang ingin diterapkan pada kolom dibawah ini\
        \n(Frekuensi harus berada diantara 0 - 9999)\
        \nCatatan: Masukkan frekuensi 0 untuk memutuskan saluran frekuensi/netral", "Submit", "Batal");
    }
    else if(textid == ATRP_RadioTD[playerid][9]) // Close
    {
        SendRPMeAboveHead(playerid, "Menutup Radio miliknya.", X11_PLUM1);
        if(!IsPlayerInAnyVehicle(playerid))
        {
            ClearAnimations(playerid, 1);
            ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
        }

		if(AccountData[playerid][pUsingOutfit] == -1)
        	RemovePlayerAttachedObject(playerid, 9);
        RadioTextdrawToggle(playerid, false);
        CancelSelectTextDraw(playerid);
    }
    else if(textid == ATRP_RadioTD[playerid][8]) // Power
    {
        RadioMicOn[playerid] = false;
        CallRemoteFunction("UpdatePlayerVoiceMicToggle", "dd", playerid, false);
        switch(ToggleRadio[playerid])
        {
            case false:
            {
                ToggleRadio[playerid] = true;
                CallRemoteFunction("UpdatePlayerVoiceRadioToggle", "dd", playerid, true);
                if(!IsPlayerInAnyVehicle(playerid))
                {
                    ClearAnimations(playerid, 1);
                    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
                }
				
                if(AccountData[playerid][pUsingOutfit] == -1)
					RemovePlayerAttachedObject(playerid, 9);
                InfoMsg(playerid, "Berhasil menyalakan radio");
                
                CancelSelectTextDraw(playerid);
                RadioTextdrawToggle(playerid, false);
            }
            case true:
            {
                ToggleRadio[playerid] = false;
                CallRemoteFunction("UpdatePlayerVoiceRadioToggle", "dd", playerid, false);
                if(!IsPlayerInAnyVehicle(playerid))
                {
                    ClearAnimations(playerid, 1);
                    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
                }
                if(AccountData[playerid][pUsingOutfit] == -1)
					RemovePlayerAttachedObject(playerid, 9);
                InfoMsg(playerid, "Berhasil mematikan radio");
                
                CancelSelectTextDraw(playerid);
                RadioTextdrawToggle(playerid, false);
            }
        }
    }
	//toys
	if(textid == P_TOYS[playerid][1]) // X Minus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_x] -= 0.020;
	
		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][2]) // X Plus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_x] += 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][4]) // Y Minus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_y] -= 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][5]) // Y Plus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_y] += 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][7]) // Z Minus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_z] -= 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
			
		}
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][8]) // Z Plus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_z] += 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][10]) // Rot x Minus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_rx] -= 3.0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][11]) // Rot x Minus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_rx] += 3.0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][13]) // Rot y Minus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_ry] -= 3.0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][14]) // Rot y Minus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_ry] += 3.0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][16]) // rot z min 
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_rz] -= 3.0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][17]) // rot z plus 
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_rz] += 3.0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][19]) // skale x min 
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_sx] -= 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][20]) // skale x plus
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_sx] += 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][22]) // skale y min 
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_sy] -= 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {			
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][23]) // skale y plus 
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_sy] += 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][25]) // skale z min 
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_sz] -= 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][26]) // skale z plus 
	{
		pToys[playerid][AccountData[playerid][toySelected]][toy_sz] += 0.020;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			SetPlayerAttachedObject(playerid,
				AccountData[playerid][toySelected],
				pToys[playerid][AccountData[playerid][toySelected]][toy_model],
				pToys[playerid][AccountData[playerid][toySelected]][toy_bone],
				pToys[playerid][AccountData[playerid][toySelected]][toy_x],
				pToys[playerid][AccountData[playerid][toySelected]][toy_y],
				pToys[playerid][AccountData[playerid][toySelected]][toy_z],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_ry],
				pToys[playerid][AccountData[playerid][toySelected]][toy_rz],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sx],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sy],
				pToys[playerid][AccountData[playerid][toySelected]][toy_sz]);
		}
		
		SetPVarInt(playerid, "UpdatedToy", 1);
	}
	if(textid == P_TOYS[playerid][27]) // Keluar
	{
		HideTDToys(playerid);
		MySQL_SavePlayerToys(playerid);
		SuccesMsg(playerid, "Berhasil menyimpan Kordinat Baru");
	}
	//atm
	if(textid == VR_ATMTD[playerid][36])// Withdraw
	{
		ShowPlayerDialog(playerid, DIALOG_ATM_WITHDRAW, DIALOG_STYLE_INPUT, ""JAVA"KARSA "WHITE"- Fleeca Bank", "Mohon masukan berapa jumlah uang yang anda ingin anda ambil:", "Submit", "Batal");
	}
	if(textid == VR_ATMTD[playerid][37])// Deposit
	{
		ShowPlayerDialog(playerid, DIALOG_ATM_DEPOSIT, DIALOG_STYLE_INPUT, ""JAVA"KARSA "WHITE"- Fleeca Bank", "Mohon masukan berapa jumlah uang yang ingin anda masukkan:", "Submit", "Batal");
	}
	if(textid == VR_ATMTD[playerid][38])// Transfer
	{
		ShowPlayerDialog(playerid, DIALOG_ATM_TRANSFER, DIALOG_STYLE_INPUT, ""JAVA"KARSA "WHITE"- Fleeca Bank", "Mohon masukkan nomor rekening yang ingin anda transfer:", "Submit", "Batal");
	}
	if(textid == VR_ATMTD[playerid][43])// Log Out
	{
		HideATMTD(playerid);
	}
	/* Clothes Sistem */
	if(textid == P_MENUCLOTHES[playerid][6]) // Pakaian
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerCameraPos(playerid, x + 0.2, y + 1.4, z + 0.8);
		SetPlayerCameraLookAt(playerid, x, y - 1.0, z + 0.2);
		for(new pdip; pdip < 12; pdip++)
		{
			PlayerTextDrawHide(playerid, P_MENUCLOTHES[playerid][pdip]);
		}

		for(new txd; txd < 16; txd++)
		{
			PlayerTextDrawShow(playerid, P_CLOTHESSELECT[playerid][txd]);
		}
		BuyClothes[playerid] = 1;
		CSelect[playerid] = 0;

		SetPlayerSkin(playerid, (AccountData[playerid][pGender] == 1) ? ClothesSkinMale[CSelect[playerid]] : ClothesSkinFemale[CSelect[playerid]]);

		static minsty[128];
		format(minsty, sizeof minsty, "%02d/%d", CSelect[playerid] + 1, ((AccountData[playerid][pGender] == 1) ? sizeof(ClothesSkinMale) : sizeof(ClothesSkinFemale)));
		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);

		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][8], "PAKAIAN");
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
		SelectTextDraw(playerid, 0x72D172FF);
	}
	if(textid == P_MENUCLOTHES[playerid][7]) // Topi Dan Helmet
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerCameraPos(playerid, x + 0.2, y + 1.4, z + 1.0);
		SetPlayerCameraLookAt(playerid, x, y - 1.0, z + 0.5);

		for(new txid; txid < 12; txid++)
		{
			PlayerTextDrawHide(playerid, P_MENUCLOTHES[playerid][txid]);
		}
		
		for(new txd; txd < 16; txd++)
		{
			PlayerTextDrawShow(playerid, P_CLOTHESSELECT[playerid][txd]);
		}
		BuyTopi[playerid] = 1;
		SelectAcc[playerid] = 0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			RemovePlayerAttachedObject(playerid, 0);
			SetPlayerAttachedObject(playerid, 9, AksesorisHat[SelectAcc[playerid]], 2, 0.356, 0.005, -0.004, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0);
		}

		static minsty[128];
		format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(AksesorisHat));
		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);

		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][8], "TOPI/HELM");
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
		SelectTextDraw(playerid, 0x72D172FF);
	}
	if(textid == P_MENUCLOTHES[playerid][8]) // Kacamata Toys
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerCameraPos(playerid, x + 0.2, y + 1.4, z + 1.0);
		SetPlayerCameraLookAt(playerid, x, y - 1.0, z + 0.5);

		for(new txid; txid < 12; txid++)
		{
			PlayerTextDrawHide(playerid, P_MENUCLOTHES[playerid][txid]);
		}
		
		for(new txd; txd < 16; txd++)
		{
			PlayerTextDrawShow(playerid, P_CLOTHESSELECT[playerid][txd]);
		}
		BuyGlasses[playerid] = 1;
		SelectAcc[playerid] = 0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			RemovePlayerAttachedObject(playerid, 1);
			SetPlayerAttachedObject(playerid, 9, GlassesToys[SelectAcc[playerid]], 2, 0.35, 0.24, -0.19, 0.0, 90.5, 86.0, 1.0, 1.0, 1.0);
		}

		static minsty[128];
		format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(GlassesToys));
		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);

		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][8], "KACAMATA");
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
		SelectTextDraw(playerid, COLOR_GREY);
	}
	if(textid == P_MENUCLOTHES[playerid][9]) // Aksesoris
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerCameraPos(playerid, x + 0.2, y + 1.6, z + 0.5);
		SetPlayerCameraLookAt(playerid, x, y - 1.0, z);
		
		for(new pdip; pdip < 12; pdip++)
		{
			PlayerTextDrawHide(playerid, P_MENUCLOTHES[playerid][pdip]);
		}

		for(new txd; txd < 16; txd++)
		{
			PlayerTextDrawShow(playerid, P_CLOTHESSELECT[playerid][txd]);
		}
		BuyTAksesoris[playerid] = 1;
		SelectAcc[playerid] = 0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			RemovePlayerAttachedObject(playerid, 2);
			SetPlayerAttachedObject(playerid, 9, AksesorisToys[SelectAcc[playerid]], 2, -0.392, 0.362, 0.000, 0.000, 0.000, 0.0000, 1.000, 1.000, 1.000);
		}

		static minsty[128];
		format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(AksesorisToys));
		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		
		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][8], "AKSESORIS");
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
		SelectTextDraw(playerid, 0x72D172FF);
	}
	if(textid == P_MENUCLOTHES[playerid][10]) // Tas / Backpack
	{
		static Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetPlayerCameraPos(playerid, x + 0.2, y + 1.6, z + 0.5);
		SetPlayerCameraLookAt(playerid, x, y - 1.0, z);

		for(new pdip; pdip < 12; pdip++)
		{
			PlayerTextDrawHide(playerid, P_MENUCLOTHES[playerid][pdip]);
		}

		for(new txd; txd < 16; txd++)
		{
			PlayerTextDrawShow(playerid, P_CLOTHESSELECT[playerid][txd]);
		}
		BuyBackpack[playerid] = 1;
		SelectAcc[playerid] = 0;

		if(AccountData[playerid][pUsingOutfit] == -1) {
			RemovePlayerAttachedObject(playerid, 3);
			SetPlayerAttachedObject(playerid, 9, BackpackToys[SelectAcc[playerid]], 2, -0.392, 0.362, 0.000, 0.000, 0.000, 0.0000, 1.000, 1.000, 1.000);
		}

		static minsty[128];
		format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(BackpackToys));
		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);

		PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][8], "TAS/KOPER");
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
		SelectTextDraw(playerid, 0x72D172FF);
	}
	if(textid == P_MENUCLOTHES[playerid][11]) // Batal
	{
		InfoMsg(playerid, "Anda membatalkan pilihan");
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, 1);
		for(new txd; txd < 12; txd ++)
		{
			PlayerTextDrawHide(playerid, P_MENUCLOTHES[playerid][txd]);
		}
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
		CancelSelectTextDraw(playerid);
	}
	if(textid == P_CLOTHESSELECT[playerid][14]) // Kembali
	{
		if(BuyClothes[playerid] == 1)
		{
			for(new txd; txd < 16; txd ++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			SetPlayerCameraFacingStore(playerid);
			BuyClothes[playerid] = 0;
			CSelect[playerid] = 0;
			if(AccountData[playerid][pUsingUniform])
			{
				SetPlayerSkin(playerid, AccountData[playerid][pUniform]);
			}
			else 
			{
				SetPlayerSkin(playerid, AccountData[playerid][pSkin]);
			}
		}

		if(BuyTopi[playerid] == 1)
		{
			for(new txd; txd < 16; txd ++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			SetPlayerCameraFacingStore(playerid);
			BuyTopi[playerid] = 0;
			SelectAcc[playerid] = 0;
			AttachPlayerToys(playerid);
			if(AccountData[playerid][pUsingOutfit] == -1)
				RemovePlayerAttachedObject(playerid, 9);
		}

		if(BuyGlasses[playerid] == 1)
		{
			for(new txd; txd < 16; txd ++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			SetPlayerCameraFacingStore(playerid);
			BuyGlasses[playerid] = 0;
			SelectAcc[playerid] = 0;
			AttachPlayerToys(playerid);
			if(AccountData[playerid][pUsingOutfit] == -1)
				RemovePlayerAttachedObject(playerid, 9);
		}

		if(BuyTAksesoris[playerid] == 1)
		{
			for(new txd; txd < 16; txd ++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			SetPlayerCameraFacingStore(playerid);
			BuyTAksesoris[playerid] = 0;
			SelectAcc[playerid] = 0;
			AttachPlayerToys(playerid);
			if(AccountData[playerid][pUsingOutfit] == -1)
				RemovePlayerAttachedObject(playerid, 9);
		}

		if(BuyBackpack[playerid] == 1)
		{
			for(new txd; txd < 16; txd ++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			SetPlayerCameraFacingStore(playerid);
			BuyBackpack[playerid] = 0;
			SelectAcc[playerid] = 0;
			AttachPlayerToys(playerid);
			if(AccountData[playerid][pUsingOutfit] == -1)
				RemovePlayerAttachedObject(playerid, 9);
		}
	}
	if(textid == P_CLOTHESSELECT[playerid][12]) // Next Cloth
	{
		if(BuyClothes[playerid] == 1)
		{
			if(CSelect[playerid] == ((AccountData[playerid][pGender] == 1) ? sizeof(ClothesSkinMale) - 1 : sizeof(ClothesSkinFemale) - 1))
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else CSelect[playerid] ++;
			SetPlayerSkin(playerid, (AccountData[playerid][pGender] == 1) ? ClothesSkinMale[CSelect[playerid]] : ClothesSkinFemale[CSelect[playerid]]);
		
			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", CSelect[playerid] + 1, ((AccountData[playerid][pGender] == 1) ? sizeof(ClothesSkinMale) : sizeof(ClothesSkinFemale)));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyTopi[playerid] == 1)
		{
			if(SelectAcc[playerid] == sizeof(AksesorisHat) - 1)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] ++;

			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, AksesorisHat[SelectAcc[playerid]], 2, 0.269, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000);
			
			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(AksesorisHat));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyGlasses[playerid] == 1)
		{
			if(SelectAcc[playerid] == sizeof(GlassesToys) - 1)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] ++;
			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, GlassesToys[SelectAcc[playerid]], 2, 0.35, 0.24, -0.19, 0.0, 90.5, 86.0, 1.0, 1.0, 1.0);

			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(GlassesToys));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyTAksesoris[playerid] == 1)
		{
			if(SelectAcc[playerid] == sizeof(AksesorisToys) - 1)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] ++;

			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, AksesorisToys[SelectAcc[playerid]], 2, -0.392, 0.362, 0.000, 0.000, 0.000, 0.0000, 1.000, 1.000, 1.000);

			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(AksesorisToys));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyBackpack[playerid] == 1)
		{
			if(SelectAcc[playerid] == sizeof(BackpackToys) - 1)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] ++;

			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, BackpackToys[SelectAcc[playerid]], 2, -0.392, 0.362, 0.000, 0.000, 0.000, 0.0000, 1.000, 1.000, 1.000);

			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(BackpackToys));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
	}
	if(textid == P_CLOTHESSELECT[playerid][11]) // Prev Cloth
	{
		if(BuyClothes[playerid] == 1)
		{
			if(CSelect[playerid] == 0)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else CSelect[playerid] --;
			SetPlayerSkin(playerid, (AccountData[playerid][pGender] == 1) ? ClothesSkinMale[CSelect[playerid]] : ClothesSkinFemale[CSelect[playerid]]);

			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", CSelect[playerid] + 1, ((AccountData[playerid][pGender] == 1) ? sizeof(ClothesSkinMale) : sizeof(ClothesSkinFemale)));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyTopi[playerid] == 1)
		{
			if(SelectAcc[playerid] == 0)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] --;

			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, AksesorisHat[SelectAcc[playerid]], 2, 0.269, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000);
			
			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(AksesorisHat));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyGlasses[playerid] == 1)
		{
			if(SelectAcc[playerid] == 0)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] --;

			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, GlassesToys[SelectAcc[playerid]], 2, 0.35, 0.24, -0.19, 0.0, 90.5, 86.0, 1.0, 1.0, 1.0);

			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(GlassesToys));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyTAksesoris[playerid] == 1)
		{
			if(SelectAcc[playerid] == 0)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] --;

			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, AksesorisToys[SelectAcc[playerid]], 2, -0.392, 0.362, 0.000, 0.000, 0.000, 0.0000, 1.000, 1.000, 1.000);

			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(AksesorisToys));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}

		if(BuyBackpack[playerid] == 1)
		{
			if(SelectAcc[playerid] == 0)
			{
				PlayerPlaySound(playerid, 4203, 0, 0, 0);
				return 0;
			}
			else SelectAcc[playerid] --;

			if(AccountData[playerid][pUsingOutfit] == -1)
				SetPlayerAttachedObject(playerid, 9, BackpackToys[SelectAcc[playerid]], 2, -0.392, 0.362, 0.000, 0.000, 0.000, 0.0000, 1.000, 1.000, 1.000);

			static minsty[128];
			format(minsty, sizeof minsty, "%02d/%d", SelectAcc[playerid] + 1, sizeof(BackpackToys));
			PlayerTextDrawSetString(playerid, P_CLOTHESSELECT[playerid][15], minsty);
		}
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
	}
	if(textid == P_CLOTHESSELECT[playerid][9]) // Rot Kiri
	{
		static Float:x, Float:y, Float:z, Float:angle;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		SetPlayerPos(playerid, x, y, z);
		SetPlayerFacingAngle(playerid, angle - 15.0);
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
	}
	if(textid == P_CLOTHESSELECT[playerid][10]) // Rot Kanana
	{
		static Float:x, Float:y, Float:z, Float:angle;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		SetPlayerPos(playerid, x, y, z);
		SetPlayerFacingAngle(playerid, angle + 15.0);
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
	}
	if(textid == P_CLOTHESSELECT[playerid][13]) // Beli Clothes
	{
		if(BuyClothes[playerid] == 1)
		{
			new price = 200;

			if(AccountData[playerid][pMoney] < price) return ErrorMsg(playerid, "Uang tidak cukup! (Price: $200)");
			TakeMoney(playerid, price);
			SuccesMsg(playerid, "Anda membeli baju seharga ~g~$200");
			
			AccountData[playerid][pSkin] = GetPlayerSkin(playerid);
			for(new tx; tx < 16; tx++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][tx]);
			}
			BuyClothes[playerid] = 0;
			SetPlayerSkin(playerid, AccountData[playerid][pSkin]);
			CancelSelectTextDraw(playerid);
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, 1);
		}

		if(BuyTopi[playerid] == 1)
		{
			AccountData[playerid][toySelected] = 0;

			new price = 80;
			if(AccountData[playerid][pMoney] < price) return ErrorMsg(playerid, "Uang kamu tidak cukup! (Price: $80)");
			TakeMoney(playerid, price);
			pToys[playerid][AccountData[playerid][toySelected]][toy_model] = AksesorisHat[SelectAcc[playerid]];
			pToys[playerid][AccountData[playerid][toySelected]][toy_status] = 1;
			pToys[playerid][AccountData[playerid][toySelected]][toy_x] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_y] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_z] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rx] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_ry] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rz] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sx] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sy] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sz] = 1.0;
			
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""JAVA"KARSA"WHITE"- Ubah Tulang(Bone)", 
			"Spine\
			\n"GRAY"Head\
			\nLeft Upper Arm\
			\n"GRAY"Right Upper Arm\
			\nLeft Hand\
			\n"GRAY"Right Hand\
			\nLeft Thigh\
			\n"GRAY"Right Thigh\
			\nLeft Foot\
			\n"GRAY"Right Foot\
			\nRight Calf\
			\n"GRAY"Left Calf\
			\nLeft Forearm\
			\n"GRAY"Right Forearm\
			\nLeft Clavicle\
			\n"GRAY"Right Clavicle\
			\nNeck\
			\n"GRAY"Jaw", "Select", "Cancel");

			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, 1);
			SuccesMsg(playerid, "Anda membeli Topi seharga ~g~$80");
			for(new txd; txd < 16; txd++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			BuyTopi[playerid] = 0;
			if(AccountData[playerid][pUsingOutfit] == -1)
					RemovePlayerAttachedObject(playerid, 9);
			CancelSelectTextDraw(playerid);
		}

		if(BuyGlasses[playerid] == 1)
		{
			AccountData[playerid][toySelected] = 1;

			new price = 50;
			if(AccountData[playerid][pMoney] < price) return ErrorMsg(playerid, "Uang kamu tidak cukup! (Price: $50)");
			TakeMoney(playerid, price);
			pToys[playerid][AccountData[playerid][toySelected]][toy_model] = GlassesToys[SelectAcc[playerid]];
			pToys[playerid][AccountData[playerid][toySelected]][toy_status] = 1;
			pToys[playerid][AccountData[playerid][toySelected]][toy_x] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_y] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_z] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rx] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_ry] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rz] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sx] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sy] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sz] = 1.0;
			
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""JAVA"KARSA"WHITE"- Ubah Tulang(Bone)", 
			"Spine\
			\n"GRAY"Head\
			\nLeft Upper Arm\
			\n"GRAY"Right Upper Arm\
			\nLeft Hand\
			\n"GRAY"Right Hand\
			\nLeft Thigh\
			\n"GRAY"Right Thigh\
			\nLeft Foot\
			\n"GRAY"Right Foot\
			\nRight Calf\
			\n"GRAY"Left Calf\
			\nLeft Forearm\
			\n"GRAY"Right Forearm\
			\nLeft Clavicle\
			\n"GRAY"Right Clavicle\
			\nNeck\
			\n"GRAY"Jaw", "Select", "Cancel");

			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, 1);
			SuccesMsg(playerid, "Anda membeli Kacamata seharga ~g~$50");
			for(new txd; txd < 16; txd++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			BuyGlasses[playerid] = 0;
			if(AccountData[playerid][pUsingOutfit] == -1)
				RemovePlayerAttachedObject(playerid, 9);
			CancelSelectTextDraw(playerid);
		}

		if(BuyTAksesoris[playerid] == 1)
		{
			AccountData[playerid][toySelected] = 2;

			new price = 100;
			if(AccountData[playerid][pMoney] < price) return ErrorMsg(playerid, "Uang kamu tidak cukup! (Price: $100)");
			TakeMoney(playerid, price);
			pToys[playerid][AccountData[playerid][toySelected]][toy_model] = AksesorisToys[SelectAcc[playerid]];
			pToys[playerid][AccountData[playerid][toySelected]][toy_status] = 1;
			pToys[playerid][AccountData[playerid][toySelected]][toy_x] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_y] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_z] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rx] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_ry] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rz] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sx] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sy] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sz] = 1.0;
			
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""JAVA"KARSA"WHITE"- Ubah Tulang(Bone)", 
			"Spine\
			\n"GRAY"Head\
			\nLeft Upper Arm\
			\n"GRAY"Right Upper Arm\
			\nLeft Hand\
			\n"GRAY"Right Hand\
			\nLeft Thigh\
			\n"GRAY"Right Thigh\
			\nLeft Foot\
			\n"GRAY"Right Foot\
			\nRight Calf\
			\n"GRAY"Left Calf\
			\nLeft Forearm\
			\n"GRAY"Right Forearm\
			\nLeft Clavicle\
			\n"GRAY"Right Clavicle\
			\nNeck\
			\n"GRAY"Jaw", "Select", "Cancel");

			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, 1);
			SuccesMsg(playerid, "Anda membeli Aksesoris seharga ~g~$100");
			for(new txd; txd < 16; txd++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			BuyTAksesoris[playerid] = 0;
			if(AccountData[playerid][pUsingOutfit] == -1)
				RemovePlayerAttachedObject(playerid, 9);
			CancelSelectTextDraw(playerid);
		}

		if(BuyBackpack[playerid] == 1)
		{
			AccountData[playerid][toySelected] = 3;

			new price = 100;
			if(AccountData[playerid][pMoney] < price) return ErrorMsg(playerid, "Uang kamu tidak cukup! (Price: 100)");
			TakeMoney(playerid, price);
			pToys[playerid][AccountData[playerid][toySelected]][toy_model] = BackpackToys[SelectAcc[playerid]];
			pToys[playerid][AccountData[playerid][toySelected]][toy_status] = 1;
			pToys[playerid][AccountData[playerid][toySelected]][toy_x] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_y] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_z] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rx] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_ry] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_rz] = 0.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sx] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sy] = 1.0;
			pToys[playerid][AccountData[playerid][toySelected]][toy_sz] = 1.0;
			
			ShowPlayerDialog(playerid, DIALOG_TOYPOSISIBUY, DIALOG_STYLE_LIST, ""JAVA"KARSA"WHITE"- Ubah Tulang(Bone)", 
			"Spine\
			\n"GRAY"Head\
			\nLeft Upper Arm\
			\n"GRAY"Right Upper Arm\
			\nLeft Hand\
			\n"GRAY"Right Hand\
			\nLeft Thigh\
			\n"GRAY"Right Thigh\
			\nLeft Foot\
			\n"GRAY"Right Foot\
			\nRight Calf\
			\n"GRAY"Left Calf\
			\nLeft Forearm\
			\n"GRAY"Right Forearm\
			\nLeft Clavicle\
			\n"GRAY"Right Clavicle\
			\nNeck\
			\n"GRAY"Jaw", "Select", "Cancel");

			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, 1);
			SuccesMsg(playerid, "Anda membeli Tas seharga ~g~$100");
			for(new txd; txd < 16; txd++)
			{
				PlayerTextDrawHide(playerid, P_CLOTHESSELECT[playerid][txd]);
			}
			BuyBackpack[playerid] = 0;
			if(AccountData[playerid][pUsingOutfit] == -1)
				RemovePlayerAttachedObject(playerid, 9);
			CancelSelectTextDraw(playerid);
		}
		PlayerPlaySound(playerid, 1053, 0, 0, 0);
	}
	// Inventory
	for(new x; x < MAX_INVENTORY; x ++)
	{
		if(textid == inv::model[playerid][x])
		{
			new Old = AccountData[playerid][pSelectItem];
			if(InventoryData[playerid][x][invExists])
			{
				UnselectItem(playerid);
				SelectItem(playerid, x);
			}
			else 
			{
				PlayerPlaySound(playerid, 1052, 0, 0, 0);
				if(Old != -1)
				{ 
					if(InventoryData[playerid][x][invExists])
						return 0;

					MoveItemToNewSlot(playerid, Old, x);
					UnselectItem(playerid);
					Old = -1;
				}
			}
		}
	}
	return 1;
}

RemovePlayerWeapon(playerid, weaponid)
{
	// Reset the player's weapons.
	ResetPlayerWeapons(playerid);
	// Set the armed slot to zero.
	SetPlayerArmedWeapon(playerid, 0);
	// Set the weapon in the slot to zero.
	AccountData[playerid][pGuns][g_aWeaponSlots[weaponid]] = 0;
	AccountData[playerid][pACTime] = gettime() + 2;
	// Set the player's weapons.
	SetWeapons(playerid);
	return 1;
}

SetCameraData(playerid)
{
	switch(random(2))
	{
		case 0: //customer parking ganton
		{
			SetPlayerCameraPos(playerid, 902.991, -901.185, 94.368);
			SetPlayerCameraLookAt(playerid, 898.424, -899.630, 93.054);
			InterpolateCameraPos(playerid, 902.991, -901.185, 94.368, 852.659, -880.944, 88.302, 30000, CAMERA_MOVE);
		}
		case 1: // vinewood
		{
			SetPlayerCameraPos(playerid, 485.642, -2111.710, 68.742);
			SetPlayerCameraLookAt(playerid, 483.018, -2107.744, 67.201);
			InterpolateCameraPos(playerid, 485.642, -2111.710, 68.742, 470.870, -2081.438, 61.609, 25000, CAMERA_MOVE);
		}
	}
	return 1;
}

CMD:setoutfit(playerid, params[]) {
	if(AccountData[playerid][pAdmin] < 6) 
	{
		return PermissionError(playerid);
	}

	if(!AccountData[playerid][pAdminDuty]) return ErrorMsg(playerid, "Anda harus onduty dewa");

	new outfitid, set, userid, string[128];

	if(sscanf(params, "dddS()[128]", userid, outfitid, set, string))
		return SendClientMessage(playerid, X11_GREY, "[Syntax] /setoutfit [playerid/PartOfName] [ID 1 - 30] [1 = true, 0 = false]");
	
	new outfit_realid = outfitid - 1;
	if(outfit_realid < OUTFIT_PIKACHU || outfit_realid > OUTFIT_MAX - 1) 
		return Error(playerid, "You have specified invalid slots.");

	if(set) {

		new day;
		if(sscanf(string, "d", day)) {
			return SendClientMessage(playerid, X11_GREY, "[Syntax] /setoutfit [playerid/PartOfName] [1 - 30] [1 = true, 0 = false] [durasi (hari)]");
		}

		if(!day) {
			return Error(playerid, "Tidak dapat kurang dari 1 hari.");
		}

		AccountData[userid][pOutfit][outfit_realid] = gettime() + (day * 86400);
		SendAdminMessage(X11_CYAN_1, "(Set Outfit)"WHITE" %s have set %s's "YELLOW"%s outfit "WHITE"to "LIGHTBLUE"%s "WHITE"for %d day.", AccountData[playerid][pUCP], ReturnName(userid), GetOutfitName(outfit_realid), (set) ? ("true") : ("false"), day);
	}
	else {
		AccountData[userid][pOutfit][outfit_realid] = 0;
		SendAdminMessage(X11_CYAN_1, "(Set Outfit)"WHITE" %s have set %s's "YELLOW"%s outfit "WHITE"to "LIGHTBLUE"%s.", AccountData[playerid][pUCP], ReturnName(userid), GetOutfitName(outfit_realid), (set) ? ("true") : ("false"));
	}
	return 1;
}

CMD:outfitlist(playerid, params[]) {
    new string[1556];

	if(AccountData[playerid][pAdmin] < 1) {
		return PermissionError(playerid);
	}

    for(new i = 0; i < 31; i++){
        strcat(string, sprintf(""WHITE"(id: %d). %s\n",i + 1, GetOutfitName(i)));
    }
	new szTitle[128];
	format(szTitle, sizeof(szTitle), "{FF0000}KARSA {FFFFFF}- Special Outfits");
	Dialog_Show(playerid, NoneDialog, DIALOG_STYLE_LIST, szTitle, string, "Close", "");
	MemSet(string, 0);
	return 1;
}

CMD:outfit(playerid, params[]) {
	ShowAccessorySelect(playerid);
	return 1;
}
stock ShowAccessorySelect(playerid) {
    new has = 0, count = 0, string[2056];

    // 1. Loop untuk ngecek outfit
    for(new i = 0; i < 31; i++) {
        if(AccountData[playerid][pOutfit][i] != 0) {
            strcat(string, sprintf(""WHITE"(id: %d). %s "GREY"(%s)\n", i + 1, GetOutfitName(i), RemainingTimelapse(AccountData[playerid][pOutfit][i])));
            ListedItems[playerid][count++] = i;
            has = 1; // Tandai kalau dia punya outfit
        }
    }

    // 2. Sekarang baru kita pake IF dan ELSE yang bener
    if(has) { 
        // Kalau dia punya outfit, baru munculin dialog
        new szTitle[128];
        format(szTitle, sizeof(szTitle), "KARSA %s %s - Special Outfits", SERVER_NAME, WHITE);
        
        // Tambahin tombol Disable di bawah list
        strcat(string, ""RED"Disable Special Outfit");
        
        Dialog_Show(playerid, SpecialOutfits, DIALOG_STYLE_LIST, szTitle, string, "Select", "Close");
    }
    else {
        // Kalau has tetap 0 (nggak ada outfit), baru keluarin error
        Error(playerid, "Anda tidak memiliki Special Outfit!");
    }

    return 1;
}
Dialog:SpecialOutfits(playerid, response, listitem ,inputtext[]) {
    if(response) {
        if(strfind(inputtext, "Disable Special Outfit") != -1) {
            RemoveExclusiveOutfit(playerid);
        }
        else {
            new outfitid = ListedItems[playerid][listitem];

            if(!AccountData[playerid][pOutfit][outfitid]) {
                Error(playerid, "Kamu tidak memiliki outfit ini.");
                ShowAccessorySelect(playerid);
                return 1;
            }
            else {
                SetExclusiveOutfit(playerid, outfitid);
				Info(playerid, "Perlu diingat! ketika anda memakai "YELLOW"special outfit"WHITE", maka tidak dapat menggunnakan:");
				Info(playerid, ""RED"Aksesoris, attachment senjata, dan hal lainnya "WHITE"yang memerlukan attached object.");
            }
        }
    }
    return 1;
}

CMD:givealloutfit(playerid, params[]) {

	if(AccountData[playerid][pAdmin] < 7) {
		return PermissionError(playerid);
	}
	if(!AccountData[playerid][pAdminDuty]) return ErrorMsg(playerid, "Anda harus onduty dewa");

	new targetid;
	if(sscanf(params, "u", targetid)) {
		return Syntax(playerid, "/givealloutfit [playerid/PartOfName]");
	}

	if(targetid == INVALID_PLAYER_ID) {
		return Error(playerid, "You have specified invalid player.");
	}

    for(new i = 0; i < 31; i++) {
        AccountData[targetid][pOutfit][i] = gettime() + (7 * 86400);
    }
	Info(playerid, "You have given all outfit to %s.", GetName(targetid));
	return 1;
}

CMD:alloutfit(playerid, params[]) {

	if(AccountData[playerid][pAdmin] < 7) {
		return PermissionError(playerid);
	}
	if(!AccountData[playerid][pAdminDuty]) return ErrorMsg(playerid, "Anda harus onduty dewa");
	
    for(new i = 0; i < 31; i++) {
        AccountData[playerid][pOutfit][i] = gettime() + (7 * 86400);
    }
	Info(playerid, "Giving you all of the special outfits!");
	return 1;
}

stock GetOutfitName(outfitid) {
    new const g_outfitnames[][] = {
        "Pikachu Head",
        "Frog Head",
        "Sonic Head",
        "Captain America Shield",
        "Goofy Head",
        "Demon Costume",
        "Venom Head",
		"Dragon Costume",
		"Grinch Costume",
		"Angel Costume",
		"Killer Costume",
		"Ghost",
		"Ballon",
		"Micky",
		"Krosh",
		"Ninja Turtle",
		"Stich",
		"Topple",
		"Kaonashi (Spirited Away)",
		"Simpson",
		"Rabbit",
		"Minecraft",
		"Emoji Love",
		"Emoji Smile",
		"Emoji Yum",
		"Emoji Tongue",
		"Monster Rainbow",
		"Poop Head",
		"Angrybird",
		"Banana",
		"Jerry"
    };

    new str[128];
    format(str, sizeof(str), g_outfitnames[outfitid]);
    return str;
}
stock SetExclusiveOutfit(playerid, outfit) {

    AccountData[playerid][pUsingOutfit] = outfit;
	SetPVarInt(playerid, "Outfit", 1);
    for(new i = 0; i < 10; i++) {
        RemovePlayerAttachedObject(playerid, i);
    }
    
    switch(outfit) {
        case OUTFIT_PIKACHU: {
            SetPlayerAttachedObject(playerid, 0, 324, 2, 0.0889, -0.0179, -0.0179, -97.6000, 12.1999, 177.4998, 0.7479, 1.0000, 1.0000, 0, 0);
            SetPlayerAttachedObject(playerid, 1, 18942, 2, 0.3769, -0.0329, 0.0459, 174.4002, 4.7999, 12.5000, 1.2279, 1.3119, 1.7079, 0, 0);
            SetPlayerAttachedObject(playerid, 2, 3106, 2, 0.1669, 0.1359, -0.0769, 2.2999, 76.3000, 53.8000, 1.1330, 1.2020, 1.0889, 0, 0);
            SetPlayerAttachedObject(playerid, 3, 3106, 2, 0.1459, 0.1479, 0.0849, 56.4001, 83.5999, 1.0999, 1.0679, 1.1240, 0.9759, 0, 0);
            SetPlayerAttachedObject(playerid, 4, 19574, 2, 0.2939, 0.0120, -0.1249, -12.9999, 20.6000, 26.7999, 5.1329, 1.0000, 1.0000, 0, 0);
            SetPlayerAttachedObject(playerid, 5, 19574, 2, 0.2599, 0.0260, 0.1570, 57.6999, 173.8004, -45.0000, 5.1329, 1.0000, 1.0000, 0, 0);
            SetPlayerAttachedObject(playerid, 6, 19577, 2, 0.1030, 0.1430, -0.1289, -28.8999, 13.3999, -3.0999, 0.8209, 0.3170, 0.8229, 0, 0);
            SetPlayerAttachedObject(playerid, 7, 19577, 2, 0.0749, 0.1550, 0.1199, 36.3001, -5.1999, 12.8999, 0.8209, 0.3170, 0.8229, 0, 0);
            SetPlayerAttachedObject(playerid, 8, 19421, 2, 0.1929, 0.1099, -0.0020, -84.9000, 23.6000, 85.0999, 0.5299, 0.9919, 0.6200, 0, 0);
            SetPlayerAttachedObject(playerid, 9, 19574, 2, 0.1249, -0.0079, 0.0080, -6.9999, 87.4000, -170.8998, 4.7470, 4.3420, 5.2360, 0, 0);
        }
        case OUTFIT_FROGHEAD: {
            SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.0180, -0.0010, 0.0000, 0.0000, 0.0000, 0.0000, 3.2790, 5.0800, 5.2700, -10842818, 0);
            SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.1200, -0.0010, -0.0440, 0.0000, 0.0000, 0.0000, 3.3840, 3.2490, 2.7410, -10381501, 0);
            SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.1170, -0.0010, 0.0630, 0.0000, 0.0000, 0.0000, 3.3840, 3.2490, 2.7410, -10381501, 0);
            SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.1260, 0.0880, 0.0690, 0.0000, 0.0000, 0.0000, 2.0720, 0.9670, 1.8630, -1, 0);
            SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.1260, 0.0920, -0.0490, 0.0000, 0.0000, 0.0000, 2.0720, 0.9670, 1.8630, -1, 0);
            SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.1180, 0.1130, -0.0490, 0.0000, 0.0000, 0.0000, 1.1200, 0.6130, 1.0130, -16777216, 0);
            SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.1150, 0.1090, 0.0690, 0.0000, 0.0000, 0.0000, 1.1200, 0.6130, 1.0130, -16777216, 0);
            SetPlayerAttachedObject(playerid, 7, 18947, 2, 0.2520, 0.0000, 0.0180, 0.0000, 0.0000, 0.0000, 1.3710, 1.3610, 1.6330, 0, 0);
            SetPlayerAttachedObject(playerid, 8, 18979, 2, 0.000000, 0.047000, 0.000000, -86.299842, 0.000000, 0.000000, 0.193999, 1.253000, 1.024999);
        }
        case OUTFIT_SONIC: {
            SetPlayerAttachedObject(playerid, 0, 954, 2, 0.1179, 0.1439, 0.0099, -90.4000, 22.0000, 89.4999, 0.1589, 0.9620, 0.1789, -16711936, 0);
            SetPlayerAttachedObject(playerid, 1, 1241, 2, 0.1489, -0.0759, -0.0670, -59.6000, -27.3999, 0.0000, 0.4499, 0.5999, 1.3059, 0xFF0000FF, 0);
            SetPlayerAttachedObject(playerid, 2, 1241, 2, 0.1149, -0.0629, -0.0060, -85.9999, -0.7999, 0.0000, 0.6189, 0.5999, 1.3870, 0xFF0000FF, 0);
            SetPlayerAttachedObject(playerid, 3, 954, 2, 0.0739, 0.0519, 0.0060, -88.1000, 23.1000, 89.0999, 0.0979, 0.8040, 0.5169, -16777216, 0);
            SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.0899, 0.0029, 0.0000, 0.0000, 86.9999, 86.8999, 4.9889, 4.4549, 4.6949, 0xFF0000FF, 0);
            SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.0390, 0.1289, 0.0019, 2.2999, 0.0000, 0.0000, 2.4089, 1.7400, 3.4649, 0xFFFFEEAA, 0);
            SetPlayerAttachedObject(playerid, 6, 1241, 2, 0.1369, -0.0819, 0.0729, -112.5999, -27.3999, 0.0000, 0.4499, 0.5999, 1.5299, 0xFF0000FF, 0);
            SetPlayerAttachedObject(playerid, 7, 19570, 2, 0.2269, 0.0249, -0.0759, -84.5999, 2.0999, 0.0000, 1.1159, 0.6389, 0.0429, 0xFF0000FF, 0);
            SetPlayerAttachedObject(playerid, 8, 19570, 2, 0.2139, 0.0249, 0.1010, -84.5999, 2.0999, -23.2000, 1.0829, 0.6439, 0.0429, 0xFF0000FF, 0);
            SetPlayerAttachedObject(playerid, 9, 3003, 2, 0.1509, 0.1219, 0.0060, 4.4000, 0.0000, -55.2999, 2.4979, 1.0000, 3.3800, 0, 0);
        }
        case OUTFIT_CAPTAIN: {
            SetPlayerAttachedObject(playerid, 1, 3101, 14, 0.079998, -0.040998, -0.033998, 0.000000, 0.000000, 0.000000, 9.818985, 8.343992, 0.982999);
            SetPlayerAttachedObject(playerid, 2, 3003,14,0.082000,-0.045999,-0.052999,0.000000,0.000000,0.000000,8.072999,6.839997,0.784000);
            SetPlayerAttachedObject(playerid, 3, 3101,14,0.083999,-0.043999,-0.073999,0.000000,0.000000,0.000000,6.006987,5.146984,0.531001);
            SetPlayerAttachedObject(playerid, 4, 3100,14,0.082999,-0.042000,-0.086999,0.000000,0.000000,0.000000,3.377001,2.844999,0.400000);
            SetPlayerAttachedObject(playerid, 6, 1247,14,0.083999,-0.043999,-0.094999,-89.899993,28.399982,0.000000,0.349000,0.157000,0.358000);
            SetPlayerAttachedObject(playerid, 5, 18922,1,-0.291999,-0.142999,-0.018000,0.600000,-2.499999,-85.099906,1.000000,5.385998,2.500000);
        }
        case OUTFIT_GOOFY: {
            SetPlayerAttachedObject(playerid, 0, 3003, 2, -0.0220, 0.2480, 0.0000, 0.0000, 0.0000, 0.0000, 0.8320, 0.6800, 0.8780, -16777216, 0); 
            SetPlayerAttachedObject(playerid, 1, 3003, 2, -0.0400, 0.0490, 0.0000, 0.0000, 0.0000, 0.0000, 3.2270, 5.5070, 4.4820, -68899, 0);
            SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.0520, -0.0010, 0.0000, 0.0000, 0.0000, 0.0000, 6.2930, 5.0800, 4.3550, -16777216, 0);
            SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.0790, 0.1470, -0.0400, 0.0000, 0.0000, 0.0000, 3.5250, 1.2990, 1.4380, -1, 0); 
            SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.0800, 0.1470, 0.0300, 0.0000, 0.0000, 0.0000, 3.5250, 1.2990, 1.4380, -1, 0); 
            SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.0730, 0.1810, 0.0360, 0.0000, 0.0000, 0.0000, 1.3870, 0.5060, 0.5820, -16777216, 0); 
            SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.0730, 0.1810, -0.0490, 0.0000, 0.0000, 0.0000, 1.3870, 0.5060, 0.5820, -16777216, 0); 
            SetPlayerAttachedObject(playerid, 7, 19578, 2, 0.0160, 0.0000, -0.2180, -92.4002, 0.0000, 157.3001, 1.3410, 1.0000, 1.9320, -13421773, 0); 
            SetPlayerAttachedObject(playerid, 8, 19578, 2, 0.0060, 0.0000, 0.2110, 90.5000, 0.0000, 159.7000, 1.3410, 1.0000, 1.9320, -13421773, 0); 
            SetPlayerAttachedObject(playerid, 9, 19488, 2, 0.2690, -0.0370, 0.0000, -0.8000, 86.1999, 94.4000, 1.2700, 1.5430, 1.9010, -13566208, 0);
        }
        case OUTFIT_DEMON: {
            SetPlayerAttachedObject(playerid, 0, 888, 1, -0.1539, 0.0000, -0.0219, 77.3002, -56.6997, -175.2004, 0.4219, 0.3590, 0.1570, -16777216, 65536); 
            SetPlayerAttachedObject(playerid, 3, 19274, 1, -0.1840, -0.1000, 0.1930, -74.1002, 5.6999, 3.0000, 3.8849, 1.5319, 0.3600, -16777216, 0); 
            SetPlayerAttachedObject(playerid, 4, 19274, 1, -0.1759, -0.1410, -0.2349, 62.0002, -7.6999, 6.5999, 3.8849, 1.5319, 0.3600, -16777216, 0); 
            SetPlayerAttachedObject(playerid, 1, 6865,2,0.033999,0.021998,0.004999,23.999973,82.399993,-166.099945,0.127999,0.130999,0.094999,-16777216,0); 
            SetPlayerAttachedObject(playerid, 5, 3101,2,0.109999,0.109000,0.090000,11.599981,-65.700004,-90.500015,1.096999,0.684000,0.905000,0,0); 
            SetPlayerAttachedObject(playerid, 6, 3101,2,0.115000,0.081000,-0.085000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000,0,0);
        }
        case OUTFIT_VENOM: {
            SetPlayerAttachedObject(playerid, 0, 18640,2, 0.001000, 0.043999, 0.002999,  174.299865,  2.399999,  22.099998,   1.428000,  1.369000,  0.991000,0,0);
            SetPlayerAttachedObject(playerid, 1, 18640,2, -0.019000,0.052999, -0.004000, 174.299865,  6.699998,  147.899826,  1.100000,  1.600999,  0.876000,0,0);
            SetPlayerAttachedObject(playerid, 2, 1974,2,0.074999,0.178999,0.081000,32.200031,-72.799980,-96.099983,1.000000,2.163997,0.983000,0,0);
            SetPlayerAttachedObject(playerid, 3, 1974,2,0.095999,0.164999,-0.091999,-39.199913,-116.200035,-79.599952,1.000000,2.163997,0.983000,0,0);
            SetPlayerAttachedObject(playerid, 4, 888, 2, 0.017999, 0.000000, -0.060000, -77.099891, -26.600023, -88.500000, 0.183000, 0.126000, 0.187999, -65536,65536);
            // SKIN ID: 49 SetPlayerAttachedObject(playerid, 5, 2782.2,-0.140999,0.165999,-0.024000,0.000000,-95.199996,-179.599990,0.321000,0.340000,0.653000,0.0);
        
        }
		case OUTFIT_DRAGON: {
			SetPlayerAttachedObject(playerid, 0, 3528, 2, 0.064000003039837, 0.082999996840954, -0.034000001847744, 0, 81.399971008301, 80.599983215332, 0.078998997807503, 0.093998998403549, 0.090999998152256);
			SetPlayerAttachedObject(playerid, 1, 3528, 1, 0.15599900484085, -0.1870000064373, 0.29500100016594, -159.30004882813, 0, 0, 0.25, 0.0079990001395345, 0.16699899733067);
			SetPlayerAttachedObject(playerid, 2, 3528, 1, 0.15599900484085, -0.1870000064373, -0.34599900245667, -21.599996566772, 0, 0, 0.25, 0.0079990001395345, 0.16699899733067);
		}
		case OUTFIT_GRINCH: {
			SetPlayerAttachedObject(playerid, 0, 19576, 2, 0.15389999747276, 0.008899999782443, 0.0080000003799796, 0, -89.299896240234, 176.60000610352, 2.4858999252319, 2.7650001049042, 3.7630000114441);
			SetPlayerAttachedObject(playerid, 1, 19570, 2, 0.20100000500679, 0.1009000018239, 0.030899999663234, -89.399803161621, 13.5, 7.8998999595642, 0.26489999890327, 0.49790000915527, 0.061900001019239);
			SetPlayerAttachedObject(playerid, 2, 19570, 2, 0.20290000736713,  0.096900001168251, -0.016000000759959, -103.5, 14.399900436401, -11.800000190735, 0.26800000667572, 0.51389998197556, 0.061900001019239);
			SetPlayerAttachedObject(playerid, 3, 19576, 2, 0.099899999797344, 0.035900000482798, 0.0049000000581145, 79.599998474121, -144.2998046875, -85.499900817871, 3.5090000629425,  3.0060000419617, 2.914999961853);
			SetPlayerAttachedObject(playerid, 4, 19078, 2,  0.29690000414848, 0, 0.0049000000581145, 176.39999389648, -176.19990539551, -51.799900054932, 0.5048999786377, 0.55290001630783, 0.55900001525879);
			SetPlayerAttachedObject(playerid, 5, 19576, 1, 0.040899999439716,  0.0098999999463558, -0.010900000110269, 13.900099754333, -91.999702453613, -160.69979858398, 5.0939002037048, 4.4000000953674, 7.5529999732971);
			SetPlayerAttachedObject(playerid, 6, 2788, 1, 0.31090000271797, 0.030899999663234, -0.024900000542402, 84.799896240234, -88.199996948242, -89.5, 0.58600002527237, 0.54900002479553, 1.7079000473022);
		}
		case OUTFIT_ANGEL: {
			SetPlayerAttachedObject(playerid, 0, 8492, 1, 0.094999000430107, -0.11100000143051, -0.0029990000184625, -90.699783325195, -96.099952697754, -109.60003662109, 0.057000000029802, 0.034000001847744, 0.090000003576279);
			SetPlayerAttachedObject(playerid, 1, 2992, 2, 0.24600000679493, 0, 0, 0, -92.700004577637, 0, 1.3659980297089, 1.3940000534058, 1);
			SetPlayerAttachedObject(playerid, 2, 2992, 2, 0.24600000679493, 0, 0.012000000104308, 0, 88.599998474121, 0, 1.3659989833832, 1.3940000534058, 1);
		}
		case OUTFIT_KILLER: {
			SetPlayerAttachedObject(playerid, 0, 2805, 2, 0.041900001466274, -0.0020000000949949, 0.0078999996185303, -5.1999001502991, -97.400001525879, 0, 0.41490000486374, 0.63190001249313, 0.2369000017643);
			SetPlayerAttachedObject(playerid, 1, 19319, 2, 0.063900001347065, 0.11100000143051, 0.043000001460314, 101.5, -62.099998474121, 78.599899291992, 0.10689999908209, 0.958899974823, 0.05290000140667);
			SetPlayerAttachedObject(playerid, 2, 19319, 2, 0.068899996578693, 0.11500000208616, -0.036899998784065, 117.80000305176, -49.200000762939, 87.89990234375, 0.063900001347065, 0.93589997291565, 0.064900003373623);
			SetPlayerAttachedObject(playerid, 3, 1133, 13, 0.35789999365807, -0.23700000345707, 0.037900000810623, 163.60000610352, -15.199899673462, -170.39999389648, 2.4828999042511, 0.49189999699593, 0.11289999634027);
			SetPlayerAttachedObject(playerid, 4, 19583, 13, 0.35690000653267, -0.018899999558926, -0.028000000864267, -17, -168.59989929199, 6.8998999595642, 1.25100004673, 1.2279000282288, 0.97000002861023);
		}
		case OUTFIT_GHOST: {
			SetPlayerAttachedObject(playerid, 0, 19200, 1, -0.16290000081062, 0.013899999670684, -0.12489999830723, -99.800003051758, -178.10000610352, -173.69990539551, 5.4299001693726, 2.2039000988007, 2.3589000701904);
			SetPlayerAttachedObject(playerid, 1, 19200, 1, -0.19390000402927, -0.0049000000581145, 0.10400000214577,  94.099899291992, -178.10000610352, -173.69990539551, 5.7838997840881, 2.4639000892639, 2.5678999423981);
			SetPlayerAttachedObject(playerid, 2, 19200, 1, 0.082000002264977, -0.0010000000474975, 0, -4.4000000953674, 176.49989318848, 176.60000610352, 5.7838997840881, 1.5938999652863, 2.1278998851776);
			SetPlayerAttachedObject(playerid, 3, 11741, 1, 0.46189999580383, 0.17890000343323, -0.046900000423193, 79.199897766113, 0, -59.799900054932, 0.24789999425411, 0.4869000017643, 1);
			SetPlayerAttachedObject(playerid, 4, 11741, 1, 0.46189999580383, 0.17890000343323, 0.060899998992682, 95.799896240234, -5.9998998641968, -117.69999694824, 0.24789999425411, 0.4869000017643, 1);
		}
		case OUTFIT_BALLON: {
			SetPlayerAttachedObject(playerid, 0, 19135, 2, 0.23190000653267, -0.013899999670684, 0.070000000298023, 10.099900245667, -119.09989929199, -6.9998998641968, 0.2790000140667, 0.299899995327, 0.32690000534058, -16776961, -16776961);
			SetPlayerAttachedObject(playerid, 1, 19087, 14, 0.36000001430511, 0, 0.020899999886751, -59, 75.699897766113, -84.89990234375, 0.080899998545647, 0.046000000089407, 0.4699000120163);
			SetPlayerAttachedObject(playerid, 2, 19063, 14, -0.93000000715256, -0.27000001072884, -0.13889999687672, -60.299999237061, 78.89990234375, 165.89990234375, 0.28290000557899, 0.26890000700951, 0.36500000953674, -16776961, -16776961);
			SetPlayerAttachedObject(playerid, 3, 19054, 13, 0.27200001478195, -0.039000000804663, -0.057900000363588, 0, 0, 0, 0.20700000226498, 0.28600001335144, 0.094899997115135);
			SetPlayerAttachedObject(playerid, 4, 19087, 14, 0.36000001430511, 0, 0.020899999886751, 1.7999000549316, 75.699897766113, -84.89990234375, 0.080899998545647, 0.046000000089407, 0.39700001478195);
			SetPlayerAttachedObject(playerid, 5, 19063, 14, -0.73189997673035, 0.010900000110269, -0.24690000712872, 0.099899999797344, 78.89990234375, 165.89990234375, 0.30790001153946, 0.29390001296997, 0.40290001034737, -16711681, -16711681);
		}
		case OUTFIT_BANANA: {
			SetPlayerAttachedObject(playerid, 0, 19578, 2, -0.016000000759959, 0.0099989995360374, 0, -7.2999901771545, 169.09928894043, 8.5000410079956, 2.7830109596252, 4.4619879722595, 5.2810077667236, 0, 0);
			SetPlayerAttachedObject(playerid, 1, 3102, 2, 0.089000001549721, 0.11299999803305, -0.049998998641968, 0, 0, 0, 1, 1, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 2, 3102, 2, 0.069999001920223, 0.11900000274181, 0.062999002635479, 41.499965667725, 0, 0, 1, 1, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 3, 19350, 2, -0.010999999940395, 0.11599899828434, -0.0070000002160668, -1.0999900102615, -7.5999870300293, -118.80018615723, 2.5170030593872, 1.1109980344772, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 4, 19350, 2, 0.16500000655651, 0.13199999928474, -0.038998998701572, -20.499946594238, 1.9000409841537, 0, 1.9250019788742, 0, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 19350, 2, 0.14599999785423, 0.13799999654293, 0.071999996900558, 2.7999920845032, -20.9000415802, 0, 1.7750049829483, 0.15599900484085, 1, 0, 0);	
		}
		case OUTFIT_ANGRYBIRD: {
			SetPlayerAttachedObject(playerid, 9, 19577, 2, 0.039900001138449, 0, 0, 0, -99.199897766113, 0, 4.3138999938965, 3.9140000343323, 5.5699000358582, 0, 0);
			SetPlayerAttachedObject(playerid, 8, 19570, 2, 0.055900000035763, 0.11689999699593, 0.03489999845624, -80.499900817871, 7.9000000953674, 0, 0.63200002908707, 0.65490001440048, 0.12300000339746, 0, 0);
			SetPlayerAttachedObject(playerid, 7, 19570, 2, 0.0658999979496, 0.10490000247955, -0.067900002002716, -112.69989776611, 13.899900436401, -29.399900436401, 0.63200002908707, 0.65490001440048, 0.12300000339746, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 2006, 2, 0.093900002539158, 0.11890000104904, 0.035000000149012, 12.399900436401, 4.0998997688293, 86, 0.40900000929832, 0.24400000274181, 0.73689997196198, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 2006, 2, 0.10189999639988, 0.10589999705553, -0.058899998664856, -28.299900054932, -15.599900245667, 77.699897766113, 0.40900000929832, 0.24400000274181, 0.73689997196198, 0, 0);
			SetPlayerAttachedObject(playerid, 4, 1576, 2, 0.008899999782443, 0.11689999699593, -0.098899997770786, 22.799900054932, 12.799900054932, 32.299900054932, 0.13889999687672, 0.61690002679825, 0.69900000095367, 0, 0);
			SetPlayerAttachedObject(playerid, 3, 2410, 2, 0.32690000534058, -0.042899999767542, 0.074000000953674, 17.60000038147, 159.59989929199, 20.5, 0.1089000031352, 0.15090000629425, 0.2520000040531, 0, 0);
		}
		case OUTFIT_POOP: {
			SetPlayerAttachedObject(playerid, 9, 19847, 2, 0.14689999818802, 0.0040000001899898, 0.013899999670684, 84.39990234375, 173.30000305176, 84.599998474121, 1.7789000272751, 0.55400002002716, 2.1370000839233, 0, 0);
			SetPlayerAttachedObject(playerid, 8, 19847, 2, 0.21789999306202, -0.0019000000320375, 0.021900000050664, 84.39990234375, 173.30000305176, 84.599998474121, 1.2999000549316, 0.45390000939369, 1.4499000310898, 0, 0);
			SetPlayerAttachedObject(playerid, 7, 19575, 2, 0.18590000271797, 0, 0.0049000000581145, -175.39999389648, -66.299896240234, -19.799900054932, 1.5180000066757, 1.8358999490738, 2.6489000320435, -1, 0);
			SetPlayerAttachedObject(playerid, 6, 19570, 2, 0.11500000208616, 0.11789999902248, 0.055900000035763, -86.89990234375, 0, 0.19990000128746, 0.76300001144409, 0.78890001773834, 0.085900001227856, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 19570, 2, 0.12989999353886, 0.11389999836683, -0.061900001019239, -97.199996948242, 8.1000003814697, -77.099998474121, 0.76300001144409, 0.78890001773834, 0.085900001227856, 0, 0);
			SetPlayerAttachedObject(playerid, 4, 19874, 2, 0.017899999395013, 0.15189999341965, -0.023000000044703, 0, 83, -5.8000001907349, 0.84789997339249, 1, 1.014899969101, 0, 0);	
		}
		case OUTFIT_MONSTER_RAINBOW: {
			SetPlayerAttachedObject(playerid, 9, 2996, 2, 0.079000003635883, 0.010900000110269, 0, -0.40000000596046, -5.5998997688293, 60.5, 4.0759000778198, 3.9289000034332, 4.6859998703003, -256, 0);
			SetPlayerAttachedObject(playerid, 8, 3100, 2, 0.11200000345707, -0.019899999722838, 0.0038999998942018, -93.900001525879, -54.599899291992, -92.799896240234, 4.5248999595642, 4.2319002151489, 3.1719000339508, 0, 0);
			SetPlayerAttachedObject(playerid, 7, 2996, 2, 0.14300000667572, 0.10989999771118, 0.075000002980232, 25.199899673462, -5.5998997688293, -25.099899291992, 1.8679000139236, 0.68900001049042, 2.0408999919891, -256, 0);
			SetPlayerAttachedObject(playerid, 6, 2996, 2, 0.15889999270439, 0.10490000247955, -0.062899999320507, -24.60000038147, -5.5998997688293, -33.099899291992, 1.8679000139236, 0.68900001049042, 2.0408999919891, -256, 0);
			SetPlayerAttachedObject(playerid, 5, 19063, 2, 0.125, 0.061900001019239, 0.060899998992682, 82.699897766113, -4.8000001907349, 7.3000001907349, 0.15989999473095, 0.15889999270439, 0.17990000545979, 0, -16777216);
			SetPlayerAttachedObject(playerid, 4, 19063, 2, 0.14000000059605, 0.059900000691414, -0.046900000423193, 82.699897766113, -4.8000001907349, 7.3000001907349, 0.14990000426769, 0.14990000426769, 0.17990000545979, 0, -16777216);
			SetPlayerAttachedObject(playerid, 3, 3100, 2, 0.070900000631809, -0.0070000002160668, -0.16789999604225, -84.999900817871, 0, -140.29989624023, 1.5788999795914, 6.4179000854492, 1.6068999767303, -65281, 0);
			SetPlayerAttachedObject(playerid, 2, 2996, 2, 0.066899999976158, 0.10800000280142, 0.0080000003799796, 4.5998997688293, -6.5999999046326, -67.099899291992, 1.7858999967575, 0.67900002002716, 2.6598999500275, -256, 0);
			SetPlayerAttachedObject(playerid, 1, 3100, 2, 0.044900000095367, 0.014899999834597, 0.15889999270439, -84.999900817871, 0, -51.199901580811, 1.5788999795914, 6.4179000854492, 1.6068999767303, -65281, 0);
			SetPlayerAttachedObject(playerid, 0, 3100, 2, 0.20200000703335, -0.019899999722838, 0.0038999998942018, -156.69999694824, -52.899898529053, -83.199897766113, 0.69989997148514, 0.833899974823, 1.9968999624252, 0, 0);
			
		}
		case OUTFIT_EMOJI_TONGUE: {
			SetPlayerAttachedObject(playerid, 9, 19574, 2, 0.098899997770786, 0.003000000026077, 0.0098999999463558, 0, 80.199996948242, 162.09989929199, 3.710000038147, 3.6340000629425, 3.9809999465942, 0, 0);
			SetPlayerAttachedObject(playerid, 8, 11740, 2, 0.14689999818802, 0.15189999341965, -0.053899999707937, 65.89990234375, -0.19990000128746, 6.6999001502991, 0.085900001227856, 0.34200000762939, 0.98400002717972, 0, 0);
			SetPlayerAttachedObject(playerid, 7, 19570, 2, 0.13500000536442, 0.15090000629425, 0.061900001019239, -77.900001525879, 11.300000190735, 0, 0.76289999485016, 0.77990001440048, 0.044900000095367, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 11740, 2, 0.070900000631809, 0.14190000295639, -0.003000000026077, 86.099899291992, -23.899900436401, 6.7999000549316, 0.66089999675751, 0.83789998292923, 0.45500001311302, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 3632, 2, 0.0439000017941, 0.14200000464916, -0.0098999999463558, -92.400001525879, 38.799900054932, 90.999900817871, 0.15000000596046, 0.29490000009537, 0.014000000432134, 0, 0);
			
		}
		case OUTFIT_EMOJI_YUM: {
			SetPlayerAttachedObject(playerid, 9, 19574, 2, 0.098899997770786, 0.003000000026077, 0.0098999999463558, 0, 80.199996948242, 162.09989929199, 3.710000038147, 3.6340000629425, 3.9809000492096, 0, 0);
			SetPlayerAttachedObject(playerid, 8, 11740, 2, 0.13889999687672, 0.14290000498295, -0.057900000363588, 65.89990234375, -0.19990000128746, 6.6999001502991, 0.42190000414848, 0.23289999365807, 0.98400002717972, 0, 0);
			SetPlayerAttachedObject(playerid, 7, 11740, 2, 0.12989999353886, 0.15090000629425, 0.063000001013279, 106.69989776611, 14.39999961853, 6.6999001502991, 0.3740000128746, 0.24690000712872, 0.98400002717972, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 11740, 2, 0.080899998545647, 0.12290000170469, -0.003000000026077, 86.099899291992, -18.799900054932, 6.7999000549316, 0.6618999838829, 0.97689998149872, 0.26390001177788, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 3632, 2, 0.048900000751019, 0.13390000164509, 0.054999999701977, -91.800201416016, 15.399900436401, 138.89999389648, 0.13089999556541, 0.26800000667572, 0, 0, 0);	
		}
		case OUTFIT_EMOJI_SMILE: {
			SetPlayerAttachedObject(playerid, 9, 19574, 2, 0.098899997770786, 0.003000000026077, 0.0098999999463558, 0, 80.199996948242, 162.09989929199, 3.710000038147, 3.6340000629425, 3.9809999465942, 0, 0);
			SetPlayerAttachedObject(playerid, 8, 11740, 2, 0.15389999747276, 0.15189999341965, -0.046900000423193, 78.199996948242, -11.10000038147, 3.9000000953674, 0.28090000152588, 0.17290000617504, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 7, 11740, 2, 0.14589999616146, 0.16490000486374, 0.042899999767542, 78.199996948242, -11.10000038147, 5.1999001502991, 0.28090000152588, 0.17290000617504, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 11740, 2, 0.061900001019239, 0.14290000498295, -0.008899999782443, 84.099899291992, -14.299900054932, 5.1999001502991, 0.38089999556541, 0.59700000286102, 1, 0, 0);
			
		}
		case OUTFIT_EMOJI_LOVE: {
			SetPlayerAttachedObject(playerid, 9, 19574, 2, 0.098899997770786, 0.003000000026077, 0.0098999999463558, 0, 80.199996948242, 162.09989929199, 3.710000038147, 3.6340000629425, 3.9809999465942, 0, 0);
			SetPlayerAttachedObject(playerid, 8, 1240, 2, 0.15389999747276, 0.14390000700951, -0.053899999707937, -49.099998474121, 119.69999694824, 36.299999237061, 0.33090001344681, 0.17290000617504, 0.37389999628067, -16776961, 0);
			SetPlayerAttachedObject(playerid, 7, 1240, 2, 0.13889999687672, 0.15289999544621, 0.056000001728535, 32.599998474121, 49.400001525879, -28.599899291992, 0.32789999246597, 0.17290000617504, 0.37490001320839, -16776961, 0);
			SetPlayerAttachedObject(playerid, 6, 11740, 2, 0.057900000363588, 0.15189999341965, -0.008899999782443, 85.299896240234, -18.799900054932, 6.6999001502991, 0.38400000333786, 0.60290002822876, 1, 0, 0);
			
		}
		case OUTFIT_MINECRAFT: {
			SetPlayerAttachedObject(playerid, 9, 19883, 2, 0.26589998602867, -0.020899999886751, 0.028899999335408, -1.6999000310898, 83.099899291992, 1.2999000549316, 3.0048999786377, 2.9690001010895, 5.6040000915527, -1, 0);
			SetPlayerAttachedObject(playerid, 8, 19579, 2, -0.038899999111891, -0.020899999886751, -0.0070000002160668, 0, 83.5, -0.60000002384186, 1.2940000295639, 2.5339000225067, 2.141900062561, 0, 0);
			SetPlayerAttachedObject(playerid, 7, 19201, 2, 0.10700000077486, 0.15600000321865, 0.10300000011921, 87.699897766113, 0, 7, 1.9139000177383, 2.1479001045227, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 19201, 2, 0.13089999556541, 0.15600000321865, -0.093000002205372, 87.699897766113, 0, 7, 1.9139000177383, 2.1479001045227, 1, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 19201, 2, 0.11289999634027, 0.15600000321865, 0.05290000140667, 87.699897766113, 0, 7, 1.9139000177383, 2.1479001045227, 1, -16777216, 0);
			SetPlayerAttachedObject(playerid, 4, 19201, 2, 0.12389999628067, 0.15600000321865, -0.0439000017941, 87.699897766113, 0, 7, 1.9139000177383, 2.1479001045227, 1, -16777216, 0);
			SetPlayerAttachedObject(playerid, 3, 19883, 2, 0.030899999663234, 0.0068999999202788, -0.0060000000521541, -1.6999000310898, 83.099899291992, 1.2999000549316, 1.1899000406265, 2.4969999790192, 3.3940000534058, -1, 0);
			SetPlayerAttachedObject(playerid, 2, 19883, 2, 0.1828999966383, 0.0068999999202788, 0.16889999806881, -1.6999000310898, 83.099899291992, 1.2999000549316, 0.45190000534058, 2.4969999790192, 3.3940000534058, -1, 0);
			SetPlayerAttachedObject(playerid, 1, 19883, 2, 0.21690000593662, 0.0028999999631196, -0.12890000641346, -1.6999000310898, 83.099899291992, 1.2999000549316, 0.45190000534058, 2.4969999790192, 3.3940000534058, -1, 0);	
		}
		case OUTFIT_RABBIT: {
			SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.063998997211456, -0.0010000000474975, 0, 0, 0, 0, 4.9860057830811, 5.0799980163574, 6.7290010452271, -10522510, 0);
			SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.29399898648262, -0.0010000000474975, -0.11899799853563, 0, 8.6000137329102, 0, 3.8940060138702, 1.2759979963303, 1.1449999809265, -11247004, 0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.29399898648262, -0.0010000000474975, 0.12000100314617, 0, -9.7999877929688, 0, 3.8940060138702, 1.2759979963303, 1.1449999809265, -11247004, 0);
			SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.1169990003109, 0.14499799907207, 0.11899899691343, 0, 0, 0, 0.93100500106812, 0.79199802875519, 0.92000097036362, -1, 0);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.1169990003109, 0.13699899613857, -0.13500100374222, 0, 0, 0, 0.93100500106812, 0.79199802875519, 0.92000097036362, -1, 0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.11599899828434, 0.15799799561501, -0.0069980002008379, 0, 0, 0, 0.30100500583649, 0.79199802875519, 1.205001950264, -16777216, 0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.11899899691343, 0.15699799358845, -0.13699899613857, 0, 0, 0, 0.34200501441956, 0.43299800157547, 0.36900201439857, -16777216, 0);
			SetPlayerAttachedObject(playerid, 7, 3003, 2, 0.11899899691343, 0.16399799287319, 0.11800000071526, 0, 0, 0, 0.34200501441956, 0.43299800157547, 0.36900201439857, -16777216, 0);
			SetPlayerAttachedObject(playerid, 8, 3003, 2, -0.015000999905169, 0.15499800443649, -0.0069980002008379, 0, 0, 0, 0.11800599843264, 0.63099801540375, 0.67500197887421, -16777216, 0);
			SetPlayerAttachedObject(playerid, 9, 915, 2, 0.056999001652002, 0.1089989989996, 0, 0, -1.2000019550323, 0, 0.2660000026226, 0, 1.0679990053177, -16777216, 0);	
		}
		case OUTFIT_SIMPSON: {
			SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.052000001072884, -0.0010000000474975, 0, 0, 0, 0, 5.850004196167, 4.7769980430603, 4.3550009727478, -15673346, 0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.088999003171921, 0.15599900484085, -0.053998999297619, -22.599994659424, 0, 0, 1.3610039949417, 0.87399899959564, 1.3680020570755, -1, 0);
			SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.088999003171921, 0.15499900281429, 0.03999999910593, 25.800003051758, 0, 0, 1.3610039949417, 0.87399899959564, 1.3680020570755, -1, 0);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, -0.034000001847744, 0.12199900299311, -0.0039989999495447, -2.0999960899353, 0, 28.499982833862, 2.3270030021667, 1.4359990358353, 2.9720010757446, -9456947, 0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.050999000668526, 0.17499899864197, -0.0069989999756217, -1.099995970726, 0, 0, 0.53100502490997, 1.5029970407486, 0.55400198698044, -12201636, 0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.086998999118805, 0.18599900603294, 0.045999001711607, 25.800003051758, 0, 0, 0.29000398516655, 0.12599900364876, 0.28700199723244, -16777216, 0);
			SetPlayerAttachedObject(playerid, 7, 3003, 2, 0.086998999118805, 0.18699899315834, -0.058998998254538, -17.999992370605, 0, 0, 0.29000398516655, 0.12599900364876, 0.28700199723244, -16777216, 0);
			SetPlayerAttachedObject(playerid, 8, 19578, 2, -0.056999001652002, 0.15700000524521, -0.010999999940395, 89.599975585938, -0.40000501275063, -86.999954223633, 0.41699901223183, 0.28700000047684, 0.63599997758865, -16777216, 0);
			SetPlayerAttachedObject(playerid, 9, 18947, 2, 0.21299900114536, -0.0039989999495447, 0, 0, 0, 0, 2.2620000839233, 1.6339999437332, 1.9620000123978, 0, 0);
			
		}
		case OUTFIT_KAONASHI: {
			SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.052000001072884, -0.0010000000474975, 0, 0, 0, 0, 6.293004989624, 5.0799989700317, 4.8179988861084, -16777216, 0);
			SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.052000001072884, 0.12899999320507, 0, 0, 0, 0, 4.9580121040344, 1.6789979934692, 3.3420000076294, -1, 0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.078000001609325, 0.16899999976158, -0.050999000668526, -16.899997711182, 0, 0, 2.9340150356293, 0.69599801301956, 0.53599900007248, -8885395, 0);
			SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.10399899631739, 0.16799999773502, 0, 0, 0, 0, 1.554013967514, 1.0239989757538, 2.7769958972931, -1, 0);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.078000001609325, 0.16799999773502, 0.0489999987185, 23.000009536743, 0, 0, 2.9340150356293, 0.69599801301956, 0.46999898552895, -8885395, 0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.1140000000596, 0.18199999630451, -0.050000000745058, 0, 0, 0, 0.49801400303841, 0.75299900770187, 0.78399497270584, -16777216, 0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.11500000208616, 0.1870000064373, 0.051998998969793, 0, 0, 0, 0.48401400446892, 0.56499898433685, 0.678995013237, -16777216, 0);
			SetPlayerAttachedObject(playerid, 7, 3003, 2, -0.059999000281096, 0.1710000038147, -0.0010000000474975, 0, 0, 0, 0.33501398563385, 0.50299900770187, 1.002995967865, -16777216, 0);
			SetPlayerAttachedObject(playerid, 8, 3003, 2, 0.087999999523163, 0.18400000035763, 0.051998998969793, 0, 0, 0, 0.22701400518417, 0.56499898433685, 0.54999500513077, -9934744, 0);
			SetPlayerAttachedObject(playerid, 9, 3003, 2, 0.089000001549721, 0.18400000035763, -0.052000001072884, 0, 0, 0, 0.22701400518417, 0.56499898433685, 0.54999500513077, -9934744, 0);	
		}
		case OUTFIT_TOPPLE: {
			SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.052000001072884, -0.0010000000474975, 0, 0, 0, 0, 4.7180061340332, 5.0799989700317, 5.5010051727295, -13744795, 0);
			SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.052000001072884, -0.0010000000474975, -0.31499901413918, 0, 0, 0, 4.573007106781, 1.3349989652634, 4.5410017967224, -15389883, 0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.052000001072884, -0.0010000000474975, 0.31799998879433, 0, 0, 0, 4.573007106781, 1.3349989652634, 4.5410017967224, -15389883, 0);
			SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.054999999701977, 0.12699900567532, 0, 0, 0, 0, 3.4040060043335, 1.8010009527206, 4.117006778717, -22296095, 0);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.083999000489712, 0.17800000309944, -0.073999002575874, 0, 0, 0, 1.0420000553131, 0.60799902677536, 1.0880000591278, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.083999000489712, 0.17800000309944, 0.078000001609325, 0, 0, 0, 1.0420000553131, 0.60799902677536, 1.0880000591278, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.083999000489712, 0.18099999427795, 0.078000001609325, 0, 0, 0, 0.86100000143051, 0.60799902677536, 0.90100002288818, -16777216, 0);
			SetPlayerAttachedObject(playerid, 7, 3003, 2, 0.083999000489712, 0.18099999427795, -0.073999002575874, 0, 0, 0, 0.86100000143051, 0.60799902677536, 0.90100002288818, -16777216, 0);
			SetPlayerAttachedObject(playerid, 8, 3003, 2, 0.0489990003407, 0.17299899458885, 0.0010000000474975, 0, 0, 0, 0.86100000143051, 0.60799902677536, 0.90100002288818, -16777216, 0);
			SetPlayerAttachedObject(playerid, 9, 19578, 2, -0.016000000759959, 0.15800000727177, 0.0070000002160668, -91.699989318848, -1.6999889612198, -88.300018310547, 0.46900001168251, 0.46599900722, 1, -16777216, 0);
		}
		case OUTFIT_STICH: {
			SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.052000001072884, -0.0010000000474975, 0, 0, 0, 0, 5.1920008659363, 4.7769980430603, 5.526997089386, -5867439, 0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.10400000214577, 0.11899899691343, -0.11099900305271, -34.000019073486, 0, -15.300004005432, 2.5350019931793, 0.60599601268768, 2.2619938850403, -2574238, 0);
			SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.10400000214577, 0.12299899756908, 0.10499899834394, 34.099979400635, 0, -16.49998664856, 2.5350019931793, 0.60599601268768, 2.2619938850403, -2574238, 0);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.062999002635479, 0.11199899762869, -0.0029990000184625, 0, 0, 0, 1.5610029697418, 2.4309980869293, 2.1419959068298, -11460091, 0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.081998996436596, 0.13199900090694, -0.0979989990592, 0, 0, 0, 1.4000020027161, 1.1369980573654, 1.309996008873, -16777216, 0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.081998996436596, 0.13699899613857, 0.086999997496605, 0, 0, 0, 1.4000020027161, 1.1369980573654, 1.309996008873, -16777216, 0);
			SetPlayerAttachedObject(playerid, 7, 3003, 2, 0.23599900305271, -0.0010000000474975, -0.18099899590015, 0, 6.1999988555908, 1.4999990463257, 5.1920008659363, 1.1209989786148, 2.391998052597, -8102338, 0);
			SetPlayerAttachedObject(playerid, 8, 3003, 2, 0.22299900650978, -0.0010000000474975, 0.1870000064373, 0, -11.200000762939, 1.4999990463257, 5.1920008659363, 1.1209989786148, 2.391998052597, -8102338, 0);
			SetPlayerAttachedObject(playerid, 9, 19578, 2, -0.014999999664724, 0.15999999642372, 0.0029990000184625, 93.200042724609, -29.899887084961, -92.799980163574, 0.3459999859333, 0.26499900221825, 0.228, -16777216, 0);
			
		}
		case OUTFIT_NINJA_TURTLE: {
			SetPlayerAttachedObject(playerid, 1, 3003, 2, -0.0010000000474975, 0.014999999664724, 0, 0, 0, -5.1999979019165, 2.7570049762726, 5.0799980163574, 4.6880021095276, -12413107, 0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.095999002456665, 0.014999999664724, 0, 0, 0, -5.1999979019165, 2.7570049762726, 3.754998922348, 3.404002904892, -12679353, 0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.082998998463154, 0.014999999664724, 0, 0, 0, -5.1999979019165, 2.2930059432983, 4.0399990081787, 3.6550040245056, -2053005, 0);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.099999003112316, 0.1410000026226, -0.06699900329113, -32.199993133545, 0.79999899864197, -10.800003051758, 0.68400001525879, 0.22299900650978, 0.65299898386002, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.094999000430107, 0.15299999713898, 0.037999998778105, 24.699996948242, 0.79999899864197, -10.800003051758, 0.68400001525879, 0.22299900650978, 0.65299898386002, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.087999001145363, 0.15999999642372, 0.032000001519918, 24.699996948242, 0.79999899864197, -10.800003051758, 0.29399999976158, 0.22299900650978, 0.28000000119209, -16777216, 0);
			SetPlayerAttachedObject(playerid, 7, 3003, 2, 0.092000000178814, 0.14900000393391, -0.062999002635479, -28.000038146973, 0.79999899864197, -10.800003051758, 0.29399999976158, 0.22299900650978, 0.28000000119209, -16777216, 0);
			SetPlayerAttachedObject(playerid, 7, 19469, 2, 0.050999999046326, -0.037999000400305, 0.086000002920628, 156.40010070801, 0, -14.60000038147, 1.9570000171661, 2.3320000171661, 2.4800000190735, -2053005, 0);
			SetPlayerAttachedObject(playerid, 9, 19578, 2, 0, 0.19900000095367, -0.018999999389052, -92.70002746582, 33.499977111816, -89.80005645752, 0.30000001192093, 0.19900000095367, 0.28299900889397, 0xFF2C2C2C, 0);	
		}
		case OUTFIT_MICKY: {
			SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.093000, 0.030000, 0.000000, 0.000000, 0.000000, 0.000000, 4.691998, 4.158000, 4.200999, 0xFF2C2C2C);
			SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.272000, 0.030000, -0.122999, 0.000000, 0.000000, 0.000000, 2.654998, 0.859998, 2.509001, 0xFF2C2C2C);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.255000, 0.032999, 0.141000, 0.000000, 0.000000, 0.000000, 2.654998, 0.859998, 2.509001, 0xFF2C2C2C);
			SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.024000, 0.118999, -0.006000, 0.000000, 0.000000, 0.000000, 2.402000, 2.761002, 3.140999, -8798977, -16777216);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.109000, 0.145999, -0.032000, -0.399995, 10.700019, -4.099998, 2.402000, 1.300001, 1.616000, 0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.109000, 0.145999, 0.015000, -0.399995, -14.499979, -4.099998, 2.402000, 1.300001, 1.616000, 0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.080000, 0.175999, -0.015000, 0.000000, 0.000000, 0.000000, 0.576999, 1.000000, 0.791999, 0xFF000000);
			SetPlayerAttachedObject(playerid, 7, 3003, 2, 0.129000, 0.188999, -0.043999, 0.000000, 3.300002, 0.000000, 0.576999, 0.238000, 0.260999, 0xFF000000);
			SetPlayerAttachedObject(playerid, 8, 3003, 2, 0.129000, 0.188999, 0.028000, 0.000000, -3.599998, 0.000000, 0.576999, 0.238000, 0.260999, 0xFF000000);
			SetPlayerAttachedObject(playerid, 9, 19421, 2, 0.094999, 0.129000, -0.010000, 92.100013, -56.300170, 92.600036, 0.668001, 0.751001, 0.213000, 0);
		}
		case OUTFIT_KROSH: {
			SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.1140000000596, 0.013000000268221, 0, 0.000000, 0.000000, 0.000000, 4.976900100708, 4.9439001083374, 4.896999835968, -256, 0);
			SetPlayerAttachedObject(playerid, 1, 2996, 2, 0.41990000009537, 0, -0.054900001734495, 0, 7.5998997688293, 0, 4.7290000915527, 1, 1.3709000349045, -256, 0);
			SetPlayerAttachedObject(playerid, 2, 2996, 2, 0.41290000081062, 0.019899999722838, 0.11590000241995, 0, -22, 0, 4.7290000915527, 1, 1.3709000349045, -256, 0);
			SetPlayerAttachedObject(playerid, 3, 19570, 2, 0.13390000164509, 0.14990000426769, 0.033900000154972, -79.400001525879, 6.9000000953674, -20.299900054932, 1.0029000043869, 0.80190002918243, 0.18189999461174, 0, 0);
			SetPlayerAttachedObject(playerid, 4, 19570, 2, 0.13889999687672, 0.15189999341965, -0.058899998664856, -100.69999694824, 6.9000000953674, 8, 0.89689999818802, 0.708899974823, 0.16689999401569, 0, 0);
			SetPlayerAttachedObject(playerid, 5, 19577, 2, 0.086000002920628, 0.19789999723434, -0.018899999558926, -160, 0, 0, 0.60089999437332, 0.53390002250671, 0.59500002861023, 0, 0);
			SetPlayerAttachedObject(playerid, 6, 2996, 2, 0.061000000685453, 0.15500000119209, -0.014000000432134, -177.89990234375, -165.60000610352, -8.5999002456665, 1.3639999628067, 1.0720000267029, 1.987900018692, -256, 0);
			SetPlayerAttachedObject(playerid, 7, 19874, 2, 0.016000000759959, 0.17090000212193, -0.023000000044703, -97.199897766113, -3, -98, 0.26190000772476, 0.46790000796318, 0.097900003194809, -1, 0);
			SetPlayerAttachedObject(playerid, 8, 2996, 2, 0.18000000715256, 0.1368999928236, -0.059900000691414, 154.69990539551, -167.30000305176, -0.60000002384186, 1.5130000114441, 1.0720000267029, 1.1728999614716,  -256, 0);
			SetPlayerAttachedObject(playerid, 9, 2996, 2, 0.18000000715256, 0.14190000295639, 0.0439000017941, -170.60000610352, -151.80000305176, 3.2999000549316, 1.2380000352859, 1.0720000267029, 1.322900056839, -256, 0);	
		}
		case OUTFIT_JERRY: {
			SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.115999, -0.014999, 0.000000, 0.000000, 0.000000, 0.000000, 4.400000, 4.178000, 3.776999, 0xFF9C663A, 0x0);
			SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.023999, 0.041999, 0.000000, 0.000000, 0.000000, 0.000000, 2.653001, 3.485000, 4.075998, 0xFF9C663A, 0x0);
			SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.198999, -0.090999, -0.133999, 28.899999, 0.000000, 0.000000, 3.816000, 3.184002, 0.684000, 0xFF9C663A, 0x0);
			SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.193999, -0.090999, 0.138000, -28.889999, 0.000000, 0.000000, 3.816000, 3.184002, 0.684000, 0xFF9C663A, 0x0);
			SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.143000, 0.123999, 0.032000, 0.000000, 0.000000, -15.599998, 1.964000, 1.000000, 0.850000, 0x0, 0x0);
			SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.143000, 0.123999, -0.042999, 0.000000, -3.900007, -15.599998, 1.964000, 1.000000, 0.850000, 0x0, 0x0);
			SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.059999, 0.132999, -0.008000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 0.680999, 0xFF000000, 0x0);
			SetPlayerAttachedObject(playerid, 7, 915, 2, 0.046999, 0.153999, -0.006000, 0.000000, 0.000000, 0.000000, 0.102999, 0.000000, 0.438000, 0xFF000000, 0x0);
			SetPlayerAttachedObject(playerid, 8, 3003, 2, 0.032999, 0.145000, -0.006000, 0.000000, -0.599999, 0.000000, 1.335999, 1.000000, 2.080000, 0x0, 0x0);
			SetPlayerAttachedObject(playerid, 9, 2429, 2, -0.161000, 0.169999, 0.046000, 88.200035, 5.900001, 92.300079, 0.276000, 0.749000, 0.265999, 0xFF000000, 0x0);
		}

    }
    return 1;
}

stock RemoveExclusiveOutfit(playerid) {
    for(new i = 0; i < 10; i++) {
        RemovePlayerAttachedObject(playerid, i);
    }
    AccountData[playerid][pUsingOutfit] = -1;
	DeletePVar(playerid, "Outfit");
}
